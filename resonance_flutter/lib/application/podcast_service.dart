import 'package:resonance_client/resonance_client.dart';
import 'package:resonance_flutter/application/serverpod_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'podcast_service.g.dart';

class PodcastService {
  PodcastService(this._client);
  final Client _client;

  Future<IngestionJob> ingest(String url) {
    return _client.podcast.ingestPodcast(url);
  }

  Stream<IngestionJob> watchJob(int jobId) {
    return _client.podcast.getJobStatus(jobId);
  }

  Future<List<Podcast>> listPodcasts() {
    return _client.podcast.listPodcasts();
  }
}

@Riverpod(keepAlive: true)
PodcastService podcastService(Ref ref) {
  final client = ref.watch(serverpodClientProvider);
  return PodcastService(client);
}

@riverpod
Future<List<Podcast>> listPodcasts(Ref ref) async {
  final service = ref.read(podcastServiceProvider);
  return service.listPodcasts();
}
