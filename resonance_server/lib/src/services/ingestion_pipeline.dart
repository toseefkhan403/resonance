import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'llm_service.dart';
import 'graph_service.dart';

/// Main pipeline orchestrator for processing podcasts
class IngestionPipeline {
  /// Processes a podcast through all stages
  static Future<void> processPodcast(
    Session session,
    int jobId,
    String userId,
    int podcastId,
  ) async {
    session.log(
      'IngestionPipeline: processPodcast started for job $jobId, podcast $podcastId',
    );
    try {
      // Update job status
      session.log(
        'IngestionPipeline: Updating status to segmented_transcript_acquisition',
      );
      await updateJobStatus(
        session,
        jobId,
        'processing',
        'segmented_transcript_acquisition',
        10,
      );

      // Agentic Segmentation and Transcript acquisition (video specific)
      final podcast = await Podcast.db.findById(session, podcastId);
      if (podcast == null) {
        session.log(
          'IngestionPipeline: Podcast $podcastId not found',
          level: LogLevel.error,
        );
        throw Exception('Podcast not found');
      }

      await updateJobStatus(
        session,
        jobId,
        'processing',
        'found_podcast',
        12,
      );

      final llmService = LLMService();

      SegmentedTranscript segmentedTranscript;
      final existingTranscript = await SegmentedTranscript.db.findFirstRow(
        session,
        where: (t) => t.videoId.equals(podcast.videoId),
      );

      await updateJobStatus(
        session,
        jobId,
        'processing',
        'found_transcript',
        30,
      );

      if (existingTranscript != null) {
        session.log(
          'IngestionPipeline: Found existing transcript for video ${podcast.videoId}',
        );
        segmentedTranscript = existingTranscript;
      } else {
        session.log(
          'IngestionPipeline: Fetching new segmented transcript for video ${podcast.videoId}',
        );
        await updateJobStatus(
          session,
          jobId,
          'processing',
          'fetching_transcript',
          15,
        );
        final fetchedTranscript = await llmService.getSegmentedTranscript(
          session,
          podcast,
          jobId,
        );
        segmentedTranscript = fetchedTranscript.copyWith(
          videoId: podcast.videoId,
        );

        // Store transcript for the user
        await SegmentedTranscript.db.insertRow(session, segmentedTranscript);
        session.log(
          'IngestionPipeline: Transcript inserted for video ${podcast.videoId}',
        );
        await updateJobStatus(
          session,
          jobId,
          'processing',
          'stored_transcript',
          45,
        );
      }

      session.log('IngestionPipeline: Updating status to node_construction');
      await updateJobStatus(
        session,
        jobId,
        'processing',
        'node_construction',
        50,
      );

      final graphService = GraphService();

      // Node construction, link similar topics
      session.log(
        'IngestionPipeline: Starting node construction for podcast $podcastId',
      );
      final nodeCount = await graphService.processTranscriptIdeas(
        session,
        userId,
        podcastId,
        podcast.videoId,
        segmentedTranscript.ideas,
      );
      session.log('IngestionPipeline: Created $nodeCount nodes');

      if (nodeCount == 0) {
        session.log(
          'IngestionPipeline: No nodes created, throwing error',
          level: LogLevel.warning,
        );
        throw Exception('No nodes created for podcast');
      }

      session.log('IngestionPipeline: Job $jobId completed successfully');
      // update podcast graphExists to true
      await Podcast.db.updateRow(
        session,
        podcast.copyWith(graphExists: true),
      );
      await updateJobStatus(session, jobId, 'completed', 'completed', 100);
    } catch (e, stackTrace) {
      session.log(
        'IngestionPipeline: Error processing podcast: $e',
        level: LogLevel.error,
        stackTrace: stackTrace,
      );
      await updateJobStatus(
        session,
        jobId,
        'failed',
        'error',
        0,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  /// Updates ingestion job status
  static Future<void> updateJobStatus(
    Session session,
    int jobId,
    String status,
    String stage,
    int progress, {
    String? errorMessage,
  }) async {
    final job = await IngestionJob.db.findById(session, jobId);
    if (job != null) {
      final updatedJob = await IngestionJob.db.updateRow(
        session,
        job.copyWith(
          status: status,
          stage: stage,
          progress: progress,
          errorMessage: errorMessage,
          updatedAt: DateTime.now(),
          completedAt: status == 'completed' || status == 'failed'
              ? DateTime.now()
              : null,
        ),
      );

      await session.messages.postMessage(
        'job-updates-$jobId',
        updatedJob,
      );
    }
  }
}
