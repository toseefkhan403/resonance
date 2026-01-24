import 'package:resonance_client/resonance_client.dart';
import 'package:resonance_flutter/application/serverpod_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'graph_service.g.dart';

class GraphService {
  GraphService(this._client);
  final Client _client;

  Future<GraphData> getGraphData() {
    return _client.graph.getGraphData();
  }
}

@Riverpod(keepAlive: true)
GraphService graphService(Ref ref) {
  final client = ref.watch(serverpodClientProvider);
  return GraphService(client);
}
