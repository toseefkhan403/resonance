import 'package:resonance_server/src/generated/endpoints.dart';

import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/youtube_service.dart';

/// Endpoint for podcast ingestion and management
class PodcastEndpoint extends Endpoint {
  /// Step 1: Ingestion orchestration
  /// Accepts a YouTube URL from an authenticated user
  /// Creates a background ingestion job and returns immediately
  Future<IngestionJob> ingestPodcast(
    Session session,
    String youtubeUrl,
  ) async {
    session.log('ingestPodcast: invoked with URL: $youtubeUrl');

    // Get authenticated user
    final userId = session.authenticated?.userIdentifier;
    if (userId == null) {
      session.log(
        'ingestPodcast: User not authenticated',
        level: LogLevel.warning,
      );
      throw Exception('User not authenticated');
    }
    session.log('ingestPodcast: User authenticated: $userId');

    final ytService = YouTubeService();

    final videoId = ytService.extractVideoId(youtubeUrl);
    if (videoId == null) {
      session.log(
        'ingestPodcast: Invalid YouTube URL: $youtubeUrl',
        level: LogLevel.warning,
      );
      throw Exception('Invalid YouTube URL');
    }
    session.log('ingestPodcast: Extracted video ID: $videoId');

    // Check if podcast already exists for this user
    final existingPodcast = await Podcast.db.findFirstRow(
      session,
      where: (p) => p.userId.equals(userId) & p.videoId.equals(videoId),
    );

    Podcast podcast;
    if (existingPodcast != null) {
      session.log(
        'ingestPodcast: Found existing podcast: ${existingPodcast.id}',
      );
      podcast = existingPodcast;

      if (podcast.graphExists == true) {
        session.log(
          'ingestPodcast: Graph already exists for podcast: ${podcast.id}',
        );
        throw Exception('Graph already exists for this podcast');
      }
    } else {
      session.log('ingestPodcast: Fetching video metadata');
      // Get video metadata
      final metadata = await ytService.getVideoMetadata(youtubeUrl);

      if (metadata == null) {
        session.log(
          'ingestPodcast: Failed to fetch video metadata',
          level: LogLevel.error,
        );
        throw Exception('Failed to fetch video metadata');
      }
      session.log('ingestPodcast: Metadata fetched: ${metadata.title}');

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
      session.log('ingestPodcast: Created new podcast record: ${podcast}');
    }

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
    session.log('ingestPodcast: Created new ingestion job: ${job}');

    // Schedule background processing using FutureCall
    await session.serverpod.futureCalls
        .callWithDelay(Duration(seconds: 1), identifier: 'processPodcast')
        .processPodcastCall
        .processPodcast(
          ProcessPodcastParams(
            jobId: job.id!,
            userId: userId,
            podcastId: podcast.id!,
          ),
        );
    session.log(
      'ingestPodcast: Scheduled background processing for job: ${job.id}',
    );

    return job;
  }

  /// Gets the status of an ingestion job as a stream
  Stream<IngestionJob> getJobStatus(
    Session session,
    int jobId,
  ) async* {
    final userId = session.authenticated?.userIdentifier;
    session.log('getJobStatus: invoked for job $jobId by user $userId');

    if (userId == null) {
      session.log(
        'getJobStatus: User not authenticated',
        level: LogLevel.warning,
      );
      throw Exception('User not authenticated');
    }

    final job = await IngestionJob.db.findById(session, jobId);
    if (job == null) {
      session.log(
        'getJobStatus: Job $jobId not found',
        level: LogLevel.warning,
      );
      throw Exception('Job not found or the user doesn\'t have access to it');
    }

    if (job.userId != userId) {
      session.log(
        'getJobStatus: User $userId unauthorized to view job $jobId (owner: ${job.userId})',
        level: LogLevel.warning,
      );
      throw Exception('Job not found or the user doesn\'t have access to it');
    }

    session.log('getJobStatus: Initial status for job $jobId: ${job.status}');
    yield job;

    if (job.status == 'completed' || job.status == 'failed') {
      session.log('getJobStatus: Job $jobId already finished as ${job.status}');
      return;
    }

    final stream = session.messages.createStream<IngestionJob>(
      'job-updates-$jobId',
    );

    session.log('getJobStatus: Listening for updates on job-updates-$jobId');
    await for (final update in stream) {
      session.log(
        'getJobStatus: Update received for job $jobId: ${update.status} - ${update.stage}',
      );
      yield update;
      if (update.status == 'completed' || update.status == 'failed') {
        session.log(
          'getJobStatus: Job $jobId finished as ${update.status}, closing stream',
        );
        break;
      }
    }
  }

  /// Lists all podcasts for the authenticated user
  Future<List<Podcast>> listPodcasts(Session session) async {
    final userId = session.authenticated?.userIdentifier;
    session.log('listPodcasts: invoked by user $userId');

    if (userId == null) {
      session.log(
        'listPodcasts: User not authenticated',
        level: LogLevel.warning,
      );
      throw Exception('User not authenticated');
    }

    final podcasts = await Podcast.db.find(
      session,
      where: (p) => p.userId.equals(userId),
      orderBy: (p) => p.createdAt,
      orderDescending: true,
    );

    session.log(
      'listPodcasts: Found ${podcasts.length} podcasts for user $userId',
    );
    return podcasts;
  }
}
