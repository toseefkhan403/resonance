import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/embedding_service.dart';
import '../services/llm_service.dart';

/// Endpoint for conversational AI ("Ask the speakers")
class ConversationEndpoint extends Endpoint {
  /// Step 12: Conversational AI with RAG
  /// Answers questions using stored knowledge graph and speaker perspective
  Future<ConversationResponse> askQuestion(
    Session session,
    String question,
  ) async {
    final userId = session.authenticated?.userIdentifier;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    // Generate embedding for the question
    final questionEmbedding = await EmbeddingService.generateEmbedding(
      session,
      question,
    );

    // Find relevant subtopics using vector similarity
    final allSubtopics = await Subtopic.db.find(
      session,
      where: (s) => s.userId.equals(userId),
    );

    final relevantSubtopics = <Subtopic>[];
    for (final subtopic in allSubtopics) {
      final similarity = EmbeddingService.cosineSimilarity(
        questionEmbedding,
        subtopic.embedding,
      );

      if (similarity >= 0.6) {
        relevantSubtopics.add(subtopic);
      }
    }

    // Sort by similarity (descending)
    relevantSubtopics.sort((a, b) {
      final simA = EmbeddingService.cosineSimilarity(
        questionEmbedding,
        a.embedding,
      );
      final simB = EmbeddingService.cosineSimilarity(
        questionEmbedding,
        b.embedding,
      );
      return simB.compareTo(simA);
    });

    // Take top 5 most relevant subtopics
    final topSubtopics = relevantSubtopics.take(5).toList();

    if (topSubtopics.isEmpty) {
      return ConversationResponse(
        answer:
            "I don't have enough information in my knowledge graph to answer that question.",
        speakers: [],
        sourceSubtopics: [],
        citations: [],
      );
    }

    // Get chunks associated with these subtopics
    final contextChunks = <ContextChunk>[];
    final speakers = <String>{};
    final citations = <TimestampReference>[];

    for (final subtopic in topSubtopics) {
      final mappings = await ChunkSubtopicMapping.db.find(
        session,
        where: (m) => m.subtopic.equals(subtopic),
      );

      for (final mapping in mappings) {
        final chunk = await mapping.chunk;
        if (chunk != null) {
          contextChunks.add(
            ContextChunk(
              text: chunk.text,
              startTime: chunk.startTime,
              endTime: chunk.endTime,
              speaker: null, // Would be populated from transcript if available
            ),
          );

          // Get podcast for citation
          final podcast = await chunk.podcast;
          if (podcast != null) {
            citations.add(
              TimestampReference(
                podcastId: podcast.id!,
                youtubeUrl: podcast.youtubeUrl,
                startTime: chunk.startTime,
                endTime: chunk.endTime,
                previewText: chunk.text.length > 100
                    ? '${chunk.text.substring(0, 100)}...'
                    : chunk.text,
              ),
            );
          }
        }
      }
    }

    // Limit context chunks to avoid token limits
    final limitedChunks = contextChunks.take(20).toList();

    // Generate answer using LLM with speaker perspective
    final answer = await LLMService.generateConversationalAnswer(
      session,
      question,
      limitedChunks,
      speakers.toList(),
    );

    return ConversationResponse(
      answer: answer,
      speakers: speakers.toList(),
      sourceSubtopics: topSubtopics.map((s) => s.name).toList(),
      citations: citations.take(10).toList(), // Limit citations
    );
  }
}
