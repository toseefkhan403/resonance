import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:graphify/graphify.dart';
import 'package:resonance_flutter/presentation/controllers/graph_controller.dart';
import 'package:resonance_flutter/presentation/utils/resonance_colors.dart';
import 'package:resonance_flutter/presentation/widgets/chat_panel.dart';
import 'package:resonance_flutter/presentation/widgets/cyberpunk_button.dart';

class ForceDirectedGraphPage extends ConsumerStatefulWidget {
  const ForceDirectedGraphPage({super.key, this.isDemo = false});

  final bool isDemo;

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
    final graphState = ref.watch(
      graphControllerProvider(isDemo: widget.isDemo),
    );

    if (graphState.isLoading) {
      return const Scaffold(
        body: Center(
          child: CupertinoActivityIndicator(color: ResonanceColors.accent),
        ),
      );
    }

    if (graphState.error != null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Graph Error: ${graphState.error}',
                  style: const TextStyle(color: ResonanceColors.accent),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: CyberpunkButton(
                    text: 'RETRY',
                    icon: Icons.refresh,
                    onPressed: () => ref
                        .read(
                          graphControllerProvider(
                            isDemo: widget.isDemo,
                          ).notifier,
                        )
                        .loadData(isDemo: widget.isDemo),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (graphState.graphData?.graphWithGranularity.isEmpty ?? true) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'No graph data available. Have you added a podcast yet?',
                  style: TextStyle(color: ResonanceColors.accent),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: CyberpunkButton(
                    text: 'ADD A PODCAST',
                    icon: Icons.add_outlined,
                    onPressed: () {
                      context.go('/home');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
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
                        .read(
                          graphControllerProvider(
                            isDemo: widget.isDemo,
                          ).notifier,
                        )
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
