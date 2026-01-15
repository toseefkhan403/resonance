import 'package:resonance_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:youtube_transcript_api/youtube_transcript_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Service for retrieving YouTube transcripts and metadata
class YouTubeService {
  /// Retrieves transcript from YouTube using youtube_transcript_api
  /// Returns transcript segments with timestamps
  static Future<FetchedTranscript> getTranscript(
    Session session,
    String youtubeUrl,
  ) async {
    try {
      // Extract video ID from URL
      final videoId = extractVideoId(youtubeUrl);
      if (videoId == null) {
        throw Exception('Invalid YouTube URL');
      }
      final api = YouTubeTranscriptApi();

      // Use youtube_transcript_api to get transcript
      final transcript = await api.fetch(videoId);

      return transcript;
    } catch (e) {
      session.log('Error fetching transcript: $e', level: LogLevel.error);
      // Fallback to speech-to-text would go here
      rethrow;
    }
  }

  /// Extracts video ID from various YouTube URL formats
  static String? extractVideoId(String url) {
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
  static Future<VideoMetadata?> getVideoMetadata(
    Session session,
    String youtubeUrl,
  ) async {
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
      session.log('Error fetching metadata: $e', level: LogLevel.error);
    }

    return null;
  }
}
