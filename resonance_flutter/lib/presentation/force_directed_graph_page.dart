import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphify/graphify.dart';
import 'package:resonance_flutter/presentation/controllers/graph_controller.dart';
import 'package:resonance_flutter/presentation/widgets/chat_panel.dart';

class ForceDirectedGraphPage extends ConsumerStatefulWidget {
  const ForceDirectedGraphPage({super.key});

  @override
  ConsumerState<ForceDirectedGraphPage> createState() =>
      _ForceDirectedGraphPageState();
}

class _ForceDirectedGraphPageState
    extends ConsumerState<ForceDirectedGraphPage> {
  @override
  void dispose() {
    super.dispose();
  }

  Map<String, dynamic> _buildChartOptions(GraphState state) {
    final graphData = state.graphData;
    if (graphData == null || graphData.graphWithGranularity.isEmpty) {
      return {};
    }

    // Use the current granular level
    final index = state.currentGranularityIndex.clamp(
      0,
      graphData.graphWithGranularity.length - 1,
    );
    final graph = graphData.graphWithGranularity[index].graph;

    final categories = graph.categories.map((c) => {'name': c.name}).toList();

    final nodes = graph.nodes.asMap().entries.map((entry) {
      final index = entry.key;
      final n = entry.value;
      return {
        // 'id': n.nodeId,
        'id': index,
        'name': n.name,
        'value': n.value,
        'category': n.category,
        'symbolSize': n.symbolSize,
        // Optional: pass other metadata if needed for tooltips
        'videoId': n.videoId,
        'summary': n.summary,
        'references': n.references,
      };
    }).toList();

    final links = graph.links.map((l) {
      return {
        'source': l.source,
        'target': l.target,
      };
    }).toList();

    return {
      'legend': {
        'data': categories.map((c) => c['name']).toList(),
        'orient': 'vertical',
        'left': 'left',
      },
      'tooltip': <String, dynamic>{},
      'series': [
        {
          'type': 'graph',
          'layout': 'force',
          'animation': true,
          'label': {'position': 'right', 'formatter': '{b}'},
          'draggable': true,
          'data': nodes,
          'categories': categories,
          'force': {
            'edgeLength': 50,
            'repulsion': 100,
            'gravity': 0.1,
          },
          'edges': links,
          'roam': true,
          'lineStyle': {
            'color': 'source',
            'curveness': 0.3,
          },
        },
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    final graphState = ref.watch(graphControllerProvider);

    if (graphState.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (graphState.error != null) {
      return Scaffold(
        body: Center(child: Text('Graph Error: ${graphState.error}')),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          // Left Panel: Graph
          Expanded(
            flex: 3,
            child: ColoredBox(
              color: const Color(0xff100c2a),
              child: graphState.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GraphifyView(
                      // Force rebuild/update when granularity changes
                      key: ValueKey(
                        'graph_${graphState.currentGranularityIndex}',
                      ),
                      controller: GraphifyController(),
                      initialOptions: _buildChartOptions(graphState),
                      onChartClick: (chartId, data) {
                        if (data['dataType'] == 'node') {
                          // todo_open dialog with node info
                        }
                      },
                    ),
            ),
          ),
          // Divider
          Container(width: 1, color: Colors.grey[300]),
          // Right Panel: Chat & Speakers
          Expanded(
            child: Column(
              children: [
                if ((graphState.graphData?.graphWithGranularity.length ?? 0) >
                    1)
                  FloatingActionButton.extended(
                    label: const Text('Cycle Granularity'),
                    icon: const Icon(Icons.grain),
                    onPressed: () => ref
                        .read(graphControllerProvider.notifier)
                        .cycleGranularity(),
                  ),
                const Expanded(child: ChatPanel()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
