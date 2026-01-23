import 'package:resonance_server/src/generated/endpoints.dart';
import 'package:resonance_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import '../services/ingestion_pipeline.dart';

/// Future call handler for processing podcasts in the background
class ProcessPodcastCall extends FutureCall {
  Future<void> processPodcast(
    Session session,
    ProcessPodcastParams? object,
  ) async {
    if (object == null) {
      session.log(
        'ProcessPodcastCall: Invoked with null params',
        level: LogLevel.error,
      );
      throw Exception('ProcessPodcastCall invoked with null params');
    }

    session.log(
      'ProcessPodcastCall: Starting processing for job ${object.jobId}, podcast ${object.podcastId}, user ${object.userId}',
    );

    try {
      await IngestionPipeline.processPodcast(
        session,
        object.jobId,
        object.userId,
        object.podcastId,
      );
      session.log(
        'ProcessPodcastCall: Completed processing for job ${object.jobId}',
      );
    } catch (e, stackTrace) {
      session.log(
        'ProcessPodcastCall: Error during processing for job ${object.jobId}: $e',
        level: LogLevel.error,
        stackTrace: stackTrace,
      );
      await session.serverpod.futureCalls.cancel('processPodcast');
    }
  }
}
