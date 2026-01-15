/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'podcast.dart' as _i2;
import 'transcript_segment.dart' as _i3;
import 'package:resonance_client/src/protocol/protocol.dart' as _i4;

abstract class Transcript implements _i1.SerializableModel {
  Transcript._({
    this.id,
    required this.podcastId,
    this.podcast,
    required this.videoId,
    required this.segments,
    required this.isGenerated,
    required this.language,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Transcript({
    int? id,
    required int podcastId,
    _i2.Podcast? podcast,
    required String videoId,
    required List<_i3.TranscriptSegment> segments,
    required bool isGenerated,
    required String language,
    DateTime? createdAt,
  }) = _TranscriptImpl;

  factory Transcript.fromJson(Map<String, dynamic> jsonSerialization) {
    return Transcript(
      id: jsonSerialization['id'] as int?,
      podcastId: jsonSerialization['podcastId'] as int,
      podcast: jsonSerialization['podcast'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Podcast>(
              jsonSerialization['podcast'],
            ),
      videoId: jsonSerialization['videoId'] as String,
      segments: _i4.Protocol().deserialize<List<_i3.TranscriptSegment>>(
        jsonSerialization['segments'],
      ),
      isGenerated: jsonSerialization['isGenerated'] as bool,
      language: jsonSerialization['language'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int podcastId;

  /// The podcast this transcript belongs to
  _i2.Podcast? podcast;

  /// The video ID this transcript belongs to
  String videoId;

  /// Transcript segments with timestamps
  List<_i3.TranscriptSegment> segments;

  /// Source: captions, stt
  bool isGenerated;

  /// Language
  String language;

  /// When the transcript was created
  DateTime createdAt;

  /// Returns a shallow copy of this [Transcript]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Transcript copyWith({
    int? id,
    int? podcastId,
    _i2.Podcast? podcast,
    String? videoId,
    List<_i3.TranscriptSegment>? segments,
    bool? isGenerated,
    String? language,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Transcript',
      if (id != null) 'id': id,
      'podcastId': podcastId,
      if (podcast != null) 'podcast': podcast?.toJson(),
      'videoId': videoId,
      'segments': segments.toJson(valueToJson: (v) => v.toJson()),
      'isGenerated': isGenerated,
      'language': language,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TranscriptImpl extends Transcript {
  _TranscriptImpl({
    int? id,
    required int podcastId,
    _i2.Podcast? podcast,
    required String videoId,
    required List<_i3.TranscriptSegment> segments,
    required bool isGenerated,
    required String language,
    DateTime? createdAt,
  }) : super._(
         id: id,
         podcastId: podcastId,
         podcast: podcast,
         videoId: videoId,
         segments: segments,
         isGenerated: isGenerated,
         language: language,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Transcript]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Transcript copyWith({
    Object? id = _Undefined,
    int? podcastId,
    Object? podcast = _Undefined,
    String? videoId,
    List<_i3.TranscriptSegment>? segments,
    bool? isGenerated,
    String? language,
    DateTime? createdAt,
  }) {
    return Transcript(
      id: id is int? ? id : this.id,
      podcastId: podcastId ?? this.podcastId,
      podcast: podcast is _i2.Podcast? ? podcast : this.podcast?.copyWith(),
      videoId: videoId ?? this.videoId,
      segments: segments ?? this.segments.map((e0) => e0.copyWith()).toList(),
      isGenerated: isGenerated ?? this.isGenerated,
      language: language ?? this.language,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
