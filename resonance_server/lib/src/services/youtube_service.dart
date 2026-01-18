import 'dart:developer';

import 'package:resonance_server/src/generated/protocol.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

/// Service for retrieving YouTube transcripts and metadata
class YouTubeService {
  /// Downloads audio from a YouTube video
  Future<File> downloadYouTubeAudio(String videoUrl) async {
    try {
      final yt = YoutubeExplode();

      final video = await yt.videos.get(videoUrl);
      final manifest = await yt.videos.streamsClient.getManifest(video.id);
      final audioStreamInfo = manifest.audioOnly.withHighestBitrate();
      final audioStream = yt.videos.streamsClient.get(audioStreamInfo);

      final fileName = '${video.title}.${audioStreamInfo.container.name}'
          .replaceAll(r'[\/:*?"<>|]', '');
      final file = File(fileName);

      final output = file.openWrite(mode: FileMode.writeOnlyAppend);
      await audioStream.pipe(output);

      await output.flush();
      await output.close();
      yt.close();

      return file;
    } catch (e) {
      log('Error downloading audio: $e');
      rethrow;
    }
  }

  /// Extracts video ID from various YouTube URL formats
  String? extractVideoId(String url) {
    final regExp = RegExp(
      r'^.*(youtu\.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*',
    );

    final match = regExp.firstMatch(url);
    if (match == null) return null;

    final videoId = match.group(2);
    if (videoId != null && videoId.length == 11) {
      return videoId;
    }

    return null;
  }

  /// Retrieves video metadata (title, channel, thumbnail)
  Future<VideoMetadata?> getVideoMetadata(String youtubeUrl) async {
    try {
      final videoId = extractVideoId(youtubeUrl);
      if (videoId == null) {
        throw Exception('Invalid YouTube URL');
      }

      // Use YouTube oEmbed API to get metadata
      final oembedUrl =
          'https://www.youtube.com/oembed?url=$youtubeUrl&format=json';

      final response = await http.get(Uri.parse(oembedUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return VideoMetadata(
          youtubeUrl: youtubeUrl,
          videoId: videoId,
          title: data['title'],
          channelName: data['author_name'],
          thumbnailUrl: data['thumbnail_url'],
        );
      }
    } catch (e) {
      log('Error fetching metadata: $e');
    }

    return null;
  }
}
