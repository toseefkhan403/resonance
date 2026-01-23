import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// Endpoint for graph visualization data
class GraphEndpoint extends Endpoint {
  /// Returns nodes and links for force-directed graph visualization
  Future<GraphData> getGraphData(Session session) async {
    final userId = session.authenticated?.userIdentifier;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    final nodes = await GraphNode.db.find(
      session,
      where: (c) => c.userId.equals(userId),
      orderBy: (c) => c.impactScore,
      orderDescending: true,
    );

    if (nodes.isEmpty) {
      return GraphData(graphWithGranularity: []);
    }

    final edges = await GraphEdge.db.find(
      session,
      where: (c) => c.userId.equals(userId),
    );

    final granularities = <GraphGranularity>[];
    // based on the number of nodes in others -> make a new granularity -> add 3 everytime
    var maxCategoryCount = 3;
    var level = 0;
    while (maxCategoryCount < nodes.length) {
      if (level >= 3) {
        break;
      }

      final (graph, otherNodeCount) = _buildGraphWithGranularity(
        level,
        maxCategoryCount,
        nodes,
        edges,
      );
      granularities.add(graph);

      if (otherNodeCount <= 4) {
        break;
      }

      maxCategoryCount += 3;
      level++;
    }

    return GraphData(graphWithGranularity: granularities);
  }

  (GraphGranularity, int) _buildGraphWithGranularity(
    int level,
    int maxCategoryCount,
    List<GraphNode> allNodes,
    List<GraphEdge> allEdges,
  ) {
    // Identify anchors (categories)
    final validCategoryCount = maxCategoryCount > allNodes.length
        ? allNodes.length
        : maxCategoryCount;

    final anchors = allNodes.sublist(0, validCategoryCount);
    final anchorIds = anchors.map((n) => n.id!).toSet();

    // Build Categories List
    final categories = anchors
        .map((n) => GraphCategory(name: n.label))
        .toList();

    // Add 'Other' category if we are not including all nodes as categories
    final hasOther = validCategoryCount < allNodes.length;
    if (hasOther) {
      categories.add(GraphCategory(name: 'Other'));
    }

    // Build Nodes List
    final nodeDisplays = <GraphNodeDisplay>[];
    final nodeIdToIndex = <int, int>{};
    var otherNodeCount = 0;

    for (var i = 0; i < allNodes.length; i++) {
      final node = allNodes[i];
      nodeIdToIndex[node.id!] = i;

      int categoryIndex;
      double symbolSize;

      if (anchorIds.contains(node.id)) {
        // This node is an anchor
        // Find its index in the anchor list to assign matching category
        categoryIndex = anchors.indexWhere((a) => a.id == node.id);
        symbolSize = 20;
      } else {
        // Find which anchor it is connected to
        // We prefer the highest impact anchor (lowest index in anchors list)
        int bestAnchorIndex = -1; // -1 means Other

        // Find neighbors in graph
        final neighborIds = <int>{};
        for (final edge in allEdges) {
          if (edge.sourceNodeId == node.id) neighborIds.add(edge.targetNodeId);
          if (edge.targetNodeId == node.id) neighborIds.add(edge.sourceNodeId);
        }

        // Check which neighbors are anchors
        for (var idx = 0; idx < anchors.length; idx++) {
          final anchor = anchors[idx];
          if (neighborIds.contains(anchor.id)) {
            bestAnchorIndex = idx;
            break; // Found highest impact anchor
          }
        }

        if (bestAnchorIndex != -1) {
          categoryIndex = bestAnchorIndex;
        } else {
          // Assign to "Other"
          categoryIndex = categories.length - 1;
          otherNodeCount++;
        }
        symbolSize = 10;
      }

      nodeDisplays.add(
        GraphNodeDisplay(
          name: node.label,
          nodeId: node.id!,
          videoId: node.videoId,
          summary: node.summary,
          primarySpeakerId: node.primarySpeakerId,
          references: node.references,
          value: node.impactScore,
          category: categoryIndex,
          symbolSize: symbolSize,
        ),
      );
    }

    // Build Links
    final linkDisplays = <GraphLinkDisplay>[];
    for (final edge in allEdges) {
      final sourceIndex = nodeIdToIndex[edge.sourceNodeId];
      final targetIndex = nodeIdToIndex[edge.targetNodeId];

      if (sourceIndex != null && targetIndex != null) {
        linkDisplays.add(
          GraphLinkDisplay(
            source: sourceIndex,
            target: targetIndex,
          ),
        );
      }
    }

    // return tuple of (graph, otherNodeCount)
    return (
      GraphGranularity(
        granularity: level,
        graph: GraphElements(
          categories: categories,
          nodes: nodeDisplays,
          links: linkDisplays,
        ),
      ),
      otherNodeCount,
    );
  }
}
