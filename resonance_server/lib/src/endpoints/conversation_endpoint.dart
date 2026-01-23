import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/llm_service.dart';

/// Endpoint for conversational AI ("Ask the speakers")
class ConversationEndpoint extends Endpoint {
  final double distanceThreshold = 0.4;

  /// Answers questions using stored knowledge graph and speaker perspective
  /// streams the generated answer as chunks
  Stream<String> askQuestion(
    Session session,
    String question,
    Speaker speaker,
  ) async* {
    final userId = session.authenticated?.userIdentifier;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    final llmService = LLMService();
    final questionEmbedding = await llmService.generateEmbedding(question);

    final nodes = await GraphNode.db.find(
      session,
      where: (n) =>
          n.userId.equals(userId) &
          n.primarySpeakerId.equals(speaker.id!) &
          (n.embedding.distanceCosine(questionEmbedding) < distanceThreshold),
    );

    final limitedNodes = nodes.take(5).toList();

    // Generate answer using LLM with speaker perspective
    final answerStream = llmService.generateConversationalAnswer(
      question,
      speaker.name,
      limitedNodes,
    );

    await for (var chunk in answerStream) {
      yield chunk;
    }
  }

  // list speakers for a podcast
  Future<List<Speaker>> listSpeakers(Session session) async {
    final userId = session.authenticated?.userIdentifier;
    session.log('listSpeakers: invoked by user $userId');

    if (userId == null) {
      session.log(
        'listSpeakers: User not authenticated',
        level: LogLevel.warning,
      );
      throw Exception('User not authenticated');
    }

    final speakers = await Speaker.db.find(
      session,
      where: (p) => p.userId.equals(userId),
      orderBy: (p) => p.createdAt,
      orderDescending: true,
    );

    session.log(
      'listSpeakers: Found ${speakers.length} speakers for user $userId',
    );
    return speakers;
  }
}
