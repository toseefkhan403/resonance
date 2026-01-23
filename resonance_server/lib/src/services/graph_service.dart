import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'llm_service.dart';

/// Service for graph construction and linking
class GraphService {
  final linkThreshold = 0.4;

  Future<int> mergeOrCreateSpeaker(
    Session session,
    String userId,
    String speakerName,
  ) async {
    final normalizedName = speakerName.toLowerCase().replaceAll(' ', '').trim();

    final existingSpeaker = await Speaker.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) & t.normalizedName.equals(normalizedName),
    );

    if (existingSpeaker != null && existingSpeaker.id != null) {
      session.log('GraphService: found existing speaker: $speakerName (id: ${existingSpeaker.id})');
      await Speaker.db.updateRow(
        session,
        existingSpeaker.copyWith(
          detectedCount: existingSpeaker.detectedCount + 1,
          updatedAt: DateTime.now(),
        ),
      );
      return existingSpeaker.id!;
    }

    session.log('GraphService: Creating new speaker: $speakerName');
    final speaker = Speaker(
      userId: userId,
      name: speakerName,
      normalizedName: normalizedName,
      detectedCount: 1,
    );

    final insertedSpeaker = await Speaker.db.insertRow(session, speaker);
    return insertedSpeaker.id!;
  }

  /// Creates nodes and links for a segmented transcript
  /// Returns the number of nodes created
  Future<int> processTranscriptIdeas(
    Session session,
    String userId,
    int podcastId,
    String videoId,
    List<TranscriptTopic> ideas,
  ) async {
    session.log('GraphService: processTranscriptIdeas started with ${ideas.length} ideas');
    final llmService = LLMService();
    int nodesCreated = 0;

    for (final idea in ideas) {
      // 1. Generate embedding for the new node
      final ideaEmbedding = await llmService.generateEmbedding(
        '${idea.label}: ${idea.summary}',
      );

      // 2. Identify speaker
      final speakerId = await mergeOrCreateSpeaker(
        session,
        userId,
        idea.primarySpeaker,
      );

      // 3. Create the Node
      final ideaNode = await GraphNode.db.insertRow(
        session,
        GraphNode(
          userId: userId,
          videoId: videoId,
          label: idea.label,
          impactScore: idea.impactScore,
          summary: idea.summary,
          primarySpeakerId: speakerId,
          references: idea.references
              .map(
                (r) => QuoteReference(
                  startTime: r.start,
                  endTime: r.end,
                  verbatimQuote: r.quote,
                ),
              )
              .toList(),
          embedding: ideaEmbedding,
        ),
      );
      nodesCreated++;

      // 4. Link similar topics based on distanceCosine (user specific)
      final similarNodes = await GraphNode.db.find(
        session,
        where: (n) =>
            n.userId.equals(userId) &
            (n.embedding.distanceCosine(ideaEmbedding) < linkThreshold),
      );
      
      if (similarNodes.isNotEmpty) {
          session.log('GraphService: Found ${similarNodes.length} similar nodes for ${idea.label}');
      }

      for (final similarNode in similarNodes) {
        if (similarNode.id == ideaNode.id) continue;

        await GraphEdge.db.insertRow(
          session,
          GraphEdge(
            userId: userId,
            sourceNodeId: ideaNode.id!,
            targetNodeId: similarNode.id!,
          ),
        );
      }
    }

    session.log('GraphService: processTranscriptIdeas completed. Nodes created: $nodesCreated');
    return nodesCreated;
  }
}
