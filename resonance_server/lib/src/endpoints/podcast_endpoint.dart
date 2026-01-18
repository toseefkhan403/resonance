import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/youtube_service.dart';
import '../future_calls/process_podcast_call.dart';

/// Endpoint for podcast ingestion and management
class PodcastEndpoint extends Endpoint {
  /// Step 1: Ingestion orchestration
  /// Accepts a YouTube URL from an authenticated user
  /// Creates a background ingestion job and returns immediately
  Future<IngestionJob> ingestPodcast(
    Session session,
    String youtubeUrl,
  ) async {
    // Get authenticated user
    final userId = session.authenticated?.userIdentifier;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    final ytService = YouTubeService();

    final videoId = ytService.extractVideoId(youtubeUrl);
    if (videoId == null) {
      throw Exception('Invalid YouTube URL');
    }

    // Check if podcast already exists for this user
    final existingPodcast = await Podcast.db.findFirstRow(
      session,
      where: (p) => p.userId.equals(userId) & p.videoId.equals(videoId),
    );

    Podcast podcast;
    if (existingPodcast != null) {
      podcast = existingPodcast;
      // find if there is an ingestion job for this podcast
      final existingJob = await IngestionJob.db.findFirstRow(
        session,
        where: (j) => j.podcastId.equals(podcast.id),
      );
      if (existingJob != null) {
        return existingJob;
      } else {
        throw Exception('Podcast already exists for this user');
      }
    }

    // Get video metadata
    final metadata = await ytService.getVideoMetadata(youtubeUrl);

    if (metadata == null) {
      throw Exception('Failed to fetch video metadata');
    }

    // Create podcast record
    podcast = await Podcast.db.insertRow(
      session,
      Podcast(
        youtubeUrl: youtubeUrl,
        videoId: videoId,
        title: metadata.title,
        channelName: metadata.channelName,
        thumbnailUrl: metadata.thumbnailUrl,
        userId: userId,
      ),
    );

    // Create ingestion job
    final job = await IngestionJob.db.insertRow(
      session,
      IngestionJob(
        podcastId: podcast.id!,
        userId: userId,
        status: 'pending',
        stage: 'pending',
        progress: 0,
      ),
    );

    // Schedule background processing using FutureCall
    // ignore: deprecated_member_use
    await session.serverpod.futureCallWithDelay(
      'processPodcast',
      ProcessPodcastParams(
        jobId: job.id!,
        userId: userId,
        podcastId: podcast.id!,
      ),
      Duration(seconds: 1),
    );

    return job;
  }

  /// Gets the status of an ingestion job as a stream
  Stream<IngestionJob> getJobStatus(
    Session session,
    int jobId,
  ) async* {
    final userId = session.authenticated?.userIdentifier;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    final job = await IngestionJob.db.findById(session, jobId);
    if (job == null || job.userId != userId) {
      throw Exception('Job not found or the user doesn\'t have access to it');
    }

    yield job;

    if (job.status == 'completed' || job.status == 'failed') {
      return;
    }

    final stream = session.messages.createStream<IngestionJob>(
      'job-updates-$jobId',
    );
    await for (final update in stream) {
      yield update;
      if (update.status == 'completed' || update.status == 'failed') {
        break;
      }
    }
  }

  /// Lists all podcasts for the authenticated user
  Future<List<Podcast>> listPodcasts(Session session) async {
    final userId = session.authenticated?.userIdentifier;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    return await Podcast.db.find(
      session,
      where: (p) => p.userId.equals(userId),
      orderBy: (p) => p.createdAt,
      orderDescending: true,
    );
  }
}
