import 'package:resonance_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import '../services/ingestion_pipeline.dart';

/// Future call handler for processing podcasts in the background
class ProcessPodcastCall extends FutureCall<ProcessPodcastParams> {
  @override
  Future<void> invoke(Session session, ProcessPodcastParams? object) async {
    if (object == null) {
      throw Exception('ProcessPodcastCall invoked with null params');
    }

    await IngestionPipeline.processPodcast(
      session,
      object.jobId,
      object.userId,
      object.podcastId,
    );
  }
}
