import 'dart:developer';

import 'package:resonance_server/src/generated/protocol.dart';
import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';
import 'dart:convert';
import 'dart:io';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_transcript_api/youtube_transcript_api.dart';

class YouTubeService {
  Future<File?> getCaptions(Session session, String videoId) async {
    try {
      final tempDir = Directory.systemTemp;
      final file = File('${tempDir.path}/$videoId.json');

      final api = YouTubeTranscriptApi();
      final transcript = await api.fetch(
        videoId,
        languages: ['en', 'en-US', 'en-GB'],
      );

      final jsonFormatter = JsonFormatter();
      final jsonContent = jsonFormatter.format(transcript);
      session.log(
        'YouTubeService: Captions fetched for video: $videoId ($jsonContent)',
      );

      await file.writeAsString(jsonContent);

      return file;
    } catch (e, stackTrace) {
      session.log(
        'Error fetching captions: $e',
        level: LogLevel.error,
        exception: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  // processing yt links directly in Gemini, no need to download audio
  Future<File> convertVideoToTranscript(
    Session session,
    String videoId, {
    void Function(int)? onProgress,
  }) async {
    try {
      var yt = YoutubeExplode();
      final manifests = await yt.videos.streams.getManifest(
        videoId,
        ytClients: [
          YoutubeApiClient({
            'context': {
              'client': {
                'clientName': 'ANDROID',
                'clientVersion': '20.10.38',
                'userAgent':
                    'com.google.android.youtube/20.10.38 (Linux; U; Android 11) gzip',
                'hl': 'en',
                'timeZone': 'UTC',
                'utcOffsetMinutes': 0,
                'osName': 'Android',
                'osVersion': '11',
              },
            },
          }, 'https://www.youtube.com/youtubei/v1/player?prettyPrint=false'),
        ],
      );

      final tempDir = Directory.systemTemp;

      final availableManifests = <AudioStreamInfo>[];

      // Check availability of each stream
      await Future.wait([
        for (final manifest in manifests.audio)
          http.head(manifest.url).then((res) {
            if (res.statusCode >= 200 && res.statusCode <= 299) {
              availableManifests.add(manifest);
            }
          }),
      ]);

      if (availableManifests.isEmpty) {
        throw Exception('No valid audio streams found.');
      }

      // Sort by bitrate ascending (lowest first)
      availableManifests.sort(
        (a, b) => a.bitrate.bitsPerSecond.compareTo(b.bitrate.bitsPerSecond),
      );
      final firstStream = availableManifests.first;

      session.log(
        'Selected Lowest Bitrate: ${firstStream.bitrate.bitsPerSecond / 1000} kbps',
      );

      var totalBytes = firstStream.size.totalBytes;
      var receivedBytes = 0;

      var file = File('${tempDir.path}/$videoId.${firstStream.container}');
      var output = file.openWrite();

      var stream = yt.videos.streams.get(firstStream);

      await for (final data in stream) {
        receivedBytes += data.length;

        var progress = ((receivedBytes / totalBytes) * 100).ceil();
        stdout.write('\rDownload Progress: $progress%');
        onProgress?.call(progress);
        output.add(data);
      }

      await output.flush();
      await output.close();
      yt.close();
      session.log('\nDownload complete: $videoId.${firstStream.container}');
      return file;
    } catch (e) {
      session.log('\nError downloading audio: $e');
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
