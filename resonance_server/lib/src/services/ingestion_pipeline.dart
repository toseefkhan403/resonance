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
    try {
      // Update job status
      await _updateJobStatus(
        session,
        jobId,
        'processing',
        'segmented_transcript_acquisition',
        10,
      );

      // Agentic Segmentation and Transcript acquisition (video specific)
      final podcast = await Podcast.db.findById(session, podcastId);
      if (podcast == null) {
        throw Exception('Podcast not found');
      }

      final llmService = LLMService();

      SegmentedTranscript segmentedTranscript;
      final existingTranscript = await SegmentedTranscript.db.findFirstRow(
        session,
        where: (t) => t.videoId.equals(podcast.videoId),
      );

      if (existingTranscript != null) {
        segmentedTranscript = existingTranscript;
      } else {
        final fetchedTranscript = await llmService.getSegmentedTranscript(
          session,
          podcast,
        );
        segmentedTranscript = fetchedTranscript.copyWith(
          videoId: podcast.videoId,
        );

        // Store transcript for the user
        await SegmentedTranscript.db.insertRow(session, segmentedTranscript);
      }

      await _updateJobStatus(
        session,
        jobId,
        'processing',
        'node_construction',
        50,
      );

      final graphService = GraphService();

      // Node construction, link similar topics
      final nodeCount = await graphService.processTranscriptIdeas(
        session,
        userId,
        podcastId,
        podcast.videoId,
        segmentedTranscript.ideas,
      );

      if (nodeCount == 0) {
        throw Exception('No nodes created for podcast');
      }

      await _updateJobStatus(session, jobId, 'completed', 'completed', 100);
    } catch (e, stackTrace) {
      session.log(
        'Error processing podcast: $e\n$stackTrace',
        level: LogLevel.error,
      );
      await _updateJobStatus(
        session,
        jobId,
        'failed',
        'error',
        0,
        errorMessage: e.toString(),
      );
    }
  }

  /// Updates ingestion job status
  static Future<void> _updateJobStatus(
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
