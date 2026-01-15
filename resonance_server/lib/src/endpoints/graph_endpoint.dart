import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// Endpoint for graph visualization data
class GraphEndpoint extends Endpoint {
  /// Step 10: Graph materialization for UI
  /// Returns nodes and links for force-directed graph visualization
  Future<GraphData> getGraphData(Session session) async {
    final userId = session.authenticated?.userIdentifier;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    // Get all categories
    final categories = await Category.db.find(
      session,
      where: (c) => c.userId.equals(userId),
    );

    // Get all subtopics
    final subtopics = await Subtopic.db.find(
      session,
      where: (s) => s.userId.equals(userId),
    );

    // Build nodes
    final nodes = <GraphNode>[];

    // Add category nodes
    for (final category in categories) {
      nodes.add(
        GraphNode(
          id: category.id!,
          type: 'category',
          label: category.name,
          category: null,
          importanceScore: 1.0,
          summary: category.description,
        ),
      );
    }

    // Add subtopic nodes
    for (final subtopic in subtopics) {
      nodes.add(
        GraphNode(
          id: subtopic.id!,
          type: 'subtopic',
          label: subtopic.name,
          category: subtopic.category?.name,
          importanceScore: subtopic.importanceScore,
          summary: subtopic.summary,
        ),
      );
    }

    // Get all relationships
    final relationships = await GraphRelationship.db.find(
      session,
      where: (r) => r.userId.equals(userId),
    );

    // Build links
    final links = relationships
        .map(
          (r) => GraphLink(
            source: r.sourceId,
            target: r.targetId,
            weight: r.weight,
            relationType: r.relationType,
          ),
        )
        .toList();

    return GraphData(
      nodes: nodes,
      links: links,
    );
  }

  /// Step 11: Node interaction behavior
  /// Returns detailed information when a subtopic node is clicked
  Future<SubtopicDetail> getSubtopicDetail(
    Session session,
    int subtopicId,
  ) async {
    final userId = session.authenticated?.userIdentifier;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    // Get subtopic
    final subtopic = await Subtopic.db.findFirstRow(
      session,
      where: (s) => s.id.equals(subtopicId) & s.userId.equals(userId),
    );

    if (subtopic == null) {
      throw Exception('Subtopic not found');
    }

    // Get all podcasts that reference this subtopic
    final evidence = await PodcastSubtopicEvidence.db.find(
      session,
      where: (e) => e.subtopic.equals(subtopic),
    );

    final podcasts = <PodcastReference>[];
    final timestamps = <TimestampReference>[];

    for (final ev in evidence) {
      final podcast = await ev.podcast;
      if (podcast != null) {
        podcasts.add(
          PodcastReference(
            podcastId: podcast.id!,
            youtubeUrl: podcast.youtubeUrl,
            title: podcast.title,
            frequency: ev.frequency,
          ),
        );

        // Get chunks for this subtopic and podcast
        final mappings = await ChunkSubtopicMapping.db.find(
          session,
          where: (m) =>
              m.subtopic.equals(subtopic) &
              (m.chunk?.podcast?.equals(podcast) ?? false),
        );

        for (final mapping in mappings) {
          final chunk = await mapping.chunk;
          if (chunk != null) {
            timestamps.add(
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

    return SubtopicDetail(
      subtopicId: subtopic.id!,
      name: subtopic.name,
      category: subtopic.category?.name,
      summary: subtopic.summary,
      podcasts: podcasts,
      timestamps: timestamps,
    );
  }
}
