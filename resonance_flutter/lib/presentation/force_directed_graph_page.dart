import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:graphify/graphify.dart';
import 'package:resonance_client/resonance_client.dart';
import 'package:resonance_flutter/application/audio_service.dart';
import 'package:resonance_flutter/presentation/controllers/graph_controller.dart';
import 'package:resonance_flutter/presentation/utils/resonance_colors.dart';
import 'package:resonance_flutter/presentation/widgets/chat_panel.dart';
import 'package:resonance_flutter/presentation/widgets/cyberpunk_button.dart';
import 'package:resonance_flutter/presentation/widgets/node_info_dialog.dart';
import 'package:resonance_flutter/presentation/widgets/resonance_dialog.dart';
import 'package:resonance_flutter/presentation/widgets/speaker_checklist.dart';

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

  @override
  Widget build(BuildContext context) {
    final graphState = ref.watch(
      graphControllerProvider(isDemo: widget.isDemo),
    );

    final graphController = ref.read(
      graphControllerProvider(isDemo: widget.isDemo).notifier,
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
                    onPressed: () {
                      ref.invalidate(
                        graphControllerProvider(isDemo: widget.isDemo),
                      );
                    },
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
                  width: 250,
                  child: CyberpunkButton(
                    text: 'ADD A PODCAST',
                    icon: Icons.podcasts,
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
              color: ResonanceColors.primary,
              child: graphState.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GraphifyView(
                      // Force rebuild/update when granularity/speaker changes
                      key: ValueKey(
                        '''graph_${graphState.currentGranularityIndex}_${graphState.selectedSpeakerIds}''',
                      ),
                      controller: GraphifyController(),
                      initialOptions: graphController.buildChartOptions(
                        graphState,
                      ),
                      onChartClick: (chartId, data) {
                        if (data['dataType'] == 'node') {
                          ref
                              .read(audioServiceProvider.notifier)
                              .playClickSound();
                          showDialog<void>(
                            context: context,
                            builder: (context) {
                              try {
                                final node = GraphNodeDisplay.fromJson(
                                  data['data'] as Map<String, dynamic>,
                                );

                                return NodeInfoDialog(
                                  node: node,
                                  speakerName: graphState.speakers
                                      .where(
                                        (speaker) =>
                                            speaker.id == node.primarySpeakerId,
                                      )
                                      .firstOrNull
                                      ?.name,
                                );
                              } catch (e) {
                                debugPrint(e.toString());
                                return const ResonanceDialog(
                                  title: 'Node Info',
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Error loading node info',
                                        style: TextStyle(
                                          color: ResonanceColors.accent,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          );
                        }
                      },
                    ),
            ),
          ),
          // Divider
          Container(width: 0.5, color: ResonanceColors.accent),
          // Right Panel: Graph config & Chat
          Expanded(
            child: ColoredBox(
              color: ResonanceColors.primaryDark,
              child: Column(
                children: [
                  SpeakerChecklist(
                    speakers: graphState.speakers,
                    selectedSpeakerIds: graphState.selectedSpeakerIds,
                    onToggle: graphController.toggleSpeaker,
                  ),
                  if ((graphState.graphData?.graphWithGranularity.length ?? 0) >
                      1)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CyberpunkButton(
                        text: 'Cycle Granularity',
                        icon: Icons.rotate_90_degrees_ccw_outlined,
                        onPressed: graphController.cycleGranularity,
                      ),
                    ),
                  const SizedBox(height: 10),
                  const Divider(
                    color: ResonanceColors.accentDark,
                    thickness: 0.5,
                  ),
                  Expanded(child: ChatPanel(speakers: graphState.speakers)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
