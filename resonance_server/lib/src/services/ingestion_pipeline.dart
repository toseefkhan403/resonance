import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'youtube_service.dart';
import 'segmentation_service.dart';
import 'chunking_service.dart' show ChunkingService;
import 'llm_service.dart';
import 'embedding_service.dart';
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
        'transcript_acquisition',
        10,
      );

      // Step 2: Transcript acquisition
      final podcast = await Podcast.db.findById(session, podcastId);
      if (podcast == null) {
        throw Exception('Podcast not found');
      }

      // TODO need speaker diarization with transcript - do it with Gemini
      final fetchedTranscript = await YouTubeService.getTranscript(
        session,
        podcast.youtubeUrl,
      );
      final segments = fetchedTranscript.snippets.map((s) {
        return TranscriptSegment(
          start: s.start,
          duration: s.duration,
          text: s.text,
        );
      }).toList();

      // Store transcript snippets
      await Transcript.db.insertRow(
        session,
        Transcript(
          podcastId: podcast.id!,
          videoId: podcast.videoId,
          segments: segments,
          isGenerated: fetchedTranscript.isGenerated,
          language: fetchedTranscript.language,
        ),
      );

      await _updateJobStatus(
        session,
        jobId,
        'processing',
        'semantic_chunking',
        30,
      );

      // Step 3: Semantic chunking
      final semanticChunks = await ChunkingService.createSemanticChunks(
        session,
        segments,
      );

      // Store semantic chunks
      // Note: After models are generated, this will use the actual SemanticChunk model
      final storedChunks =
          <dynamic>[]; // Will be SemanticChunk after generation
      for (final chunk in semanticChunks) {
        // This will be uncommented after model generation
        /*
        final stored = await SemanticChunk.insert(
          session,
          SemanticChunk(
            transcript: transcript,
            podcast: podcast,
            startTime: chunk.startTime,
            endTime: chunk.endTime,
            text: chunk.text,
            embedding: chunk.embedding,
          ),
        );
        storedChunks.add(stored);
        */
        // Temporary placeholder
        storedChunks.add(chunk);
      }

      await _updateJobStatus(
        session,
        jobId,
        'processing',
        'topic_extraction',
        50,
      );

      // Step 5: Topic extraction
      final subtopicMap =
          <
            String,
            List<dynamic>
          >{}; // Will be List<SemanticChunk> after generation

      for (final chunk in storedChunks) {
        // Extract text and timestamps from chunk
        // After model generation, this will use the actual SemanticChunk model
        final chunkText = chunk is SemanticChunk ? chunk.text : '';
        final chunkStartTime = chunk is SemanticChunk ? chunk.startTime : 0.0;
        final chunkEndTime = chunk is SemanticChunk ? chunk.endTime : 0.0;

        if (chunkText.isEmpty) continue; // Skip if we can't extract text
        final topicResult = await LLMService.extractTopics(
          session,
          chunkText,
        );

        // Step 6: Topic normalization and merge
        final subtopicEmbedding = await EmbeddingService.generateEmbedding(
          session,
          topicResult.primarySubtopic,
        );

        // Get existing categories
        final existingCategories = await Category.db.find(
          session,
          where: (c) => c.userId.equals(userId),
        );
        final categoryNames = existingCategories.map((c) => c.name).toList();

        final categoryName = await LLMService.categorizeSubtopic(
          session,
          topicResult.primarySubtopic,
          categoryNames,
        );

        // Step 7: Global graph merge
        final subtopic = await GraphService.mergeOrCreateSubtopic(
          session,
          userId,
          topicResult.primarySubtopic,
          subtopicEmbedding,
          categoryName,
          topicResult.secondaryConcepts,
          topicResult.summary,
        );

        final savedSubtopic = await Subtopic.db.insertRow(session, subtopic);

        // Store chunk-to-subtopic mapping
        // Note: After model generation, uncomment this:
        /*
        await ChunkSubtopicMapping.insert(
          session,
          ChunkSubtopicMapping(
            chunk: chunk, // Will be the actual SemanticChunk
            subtopic: savedSubtopic,
            confidence: 0.8,
          ),
        );
        */

        // Track subtopic for relationship creation
        if (!subtopicMap.containsKey(savedSubtopic.name)) {
          subtopicMap[savedSubtopic.name] = [];
        }
        // After model generation, add the actual chunk
        // subtopicMap[savedSubtopic.name]!.add(chunk);

        // Update podcast-subtopic evidence
        await _updatePodcastSubtopicEvidence(session, podcast, savedSubtopic);
      }

      await _updateJobStatus(
        session,
        jobId,
        'processing',
        'relationship_construction',
        80,
      );

      // Step 8: Relationship construction
      final allSubtopics = await Subtopic.db.find(
        session,
        where: (s) => s.userId.equals(userId),
      );

      for (final entry in subtopicMap.entries) {
        final subtopic = await Subtopic.db.findFirstRow(
          session,
          where: (s) => s.userId.equals(userId) & s.name.equals(entry.key),
        );

        if (subtopic != null) {
          // Find related subtopics
          final relatedSubtopics = <Subtopic>[];
          for (final other in allSubtopics) {
            if (other.id != subtopic.id) {
              final similarity = EmbeddingService.cosineSimilarity(
                subtopic.embedding,
                other.embedding,
              );
              if (similarity >= 0.7) {
                relatedSubtopics.add(other);
              }
            }
          }

          await GraphService.createRelationships(
            session,
            userId,
            subtopic,
            podcast,
            relatedSubtopics,
          );
        }
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

  /// Updates podcast-subtopic evidence
  static Future<void> _updatePodcastSubtopicEvidence(
    Session session,
    Podcast podcast,
    Subtopic subtopic,
  ) async {
    final existing = await PodcastSubtopicEvidence.db.findFirstRow(
      session,
      where: (e) => e.podcast.equals(podcast) & e.subtopic.equals(subtopic),
    );

    if (existing != null) {
      await PodcastSubtopicEvidence.db.updateRow(
        session,
        existing.copyWith(frequency: existing.frequency + 1),
      );
    } else {
      await PodcastSubtopicEvidence.db.insertRow(
        session,
        PodcastSubtopicEvidence(
          podcast: podcast,
          subtopic: subtopic,
          frequency: 1,
        ),
      );
    }
  }
}
