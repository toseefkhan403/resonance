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

/// Serializable model for passing parameters to the future call
class ProcessPodcastParams implements SerializableModel {
  final int jobId;
  final String userId;
  final int podcastId;

  ProcessPodcastParams({
    required this.jobId,
    required this.userId,
    required this.podcastId,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'jobId': jobId,
      'userId': userId,
      'podcastId': podcastId,
    };
  }

  factory ProcessPodcastParams.fromJson(Map<String, dynamic> json) {
    return ProcessPodcastParams(
      jobId: json['jobId'] as int,
      userId: json['userId'] as String,
      podcastId: json['podcastId'] as int,
    );
  }
}
