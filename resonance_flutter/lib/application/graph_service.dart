import 'package:resonance_client/resonance_client.dart';
import 'package:resonance_flutter/application/serverpod_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'graph_service.g.dart';

class GraphService {
  GraphService(this._client);
  final Client _client;

  Future<GraphData> getGraphData({bool isDemo = false}) {
    // Determine which endpoint to use based on isDemo
    if (isDemo) {
      return _client.graph.getDemoGraphData();
    }
    return _client.graph.getGraphData();
  }

  Future<List<Speaker>> listSpeakers() {
    return _client.conversation.listSpeakers();
  }
}

@Riverpod(keepAlive: true)
GraphService graphService(Ref ref) {
  final client = ref.watch(serverpodClientProvider);
  return GraphService(client);
}
