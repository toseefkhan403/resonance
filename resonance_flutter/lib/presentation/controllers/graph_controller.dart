import 'dart:async';

import 'package:resonance_client/resonance_client.dart';
import 'package:resonance_flutter/application/graph_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'graph_controller.g.dart';

class GraphState {
  const GraphState({
    this.graphData,
    this.isLoading = true,
    this.error,
    this.currentGranularityIndex = 0,
  });

  final GraphData? graphData;
  final bool isLoading;
  final String? error;
  final int currentGranularityIndex;

  GraphState copyWith({
    GraphData? graphData,
    bool? isLoading,
    String? error,
    int? currentGranularityIndex,
  }) {
    return GraphState(
      graphData: graphData ?? this.graphData,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentGranularityIndex:
          currentGranularityIndex ?? this.currentGranularityIndex,
    );
  }
}

@riverpod
class GraphController extends _$GraphController {
  @override
  GraphState build({bool isDemo = false}) {
    // Load data initially
    unawaited(loadData(isDemo: isDemo));
    return const GraphState();
  }

  Future<void> loadData({bool isDemo = false}) async {
    try {
      final service = ref.read(graphServiceProvider);
      final data = await service.getGraphData(isDemo: isDemo);

      var granularityIndex = 0;
      if (data.graphWithGranularity.isNotEmpty) {
        granularityIndex = data.graphWithGranularity.length - 1;
      }

      state = state.copyWith(
        graphData: data,
        currentGranularityIndex: granularityIndex,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  void cycleGranularity() {
    final data = state.graphData;
    if (data == null || data.graphWithGranularity.isEmpty) return;

    final nextIndex =
        (state.currentGranularityIndex + 1) % data.graphWithGranularity.length;

    state = state.copyWith(currentGranularityIndex: nextIndex);
  }
}
