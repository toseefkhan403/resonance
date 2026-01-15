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
import 'transcript.dart' as _i2;
import 'podcast.dart' as _i3;
import 'package:resonance_client/src/protocol/protocol.dart' as _i4;

abstract class SemanticChunk implements _i1.SerializableModel {
  SemanticChunk._({
    this.id,
    required this.transcriptId,
    this.transcript,
    required this.podcastId,
    this.podcast,
    required this.startTime,
    required this.endTime,
    required this.text,
    required this.embedding,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory SemanticChunk({
    int? id,
    required int transcriptId,
    _i2.Transcript? transcript,
    required int podcastId,
    _i3.Podcast? podcast,
    required double startTime,
    required double endTime,
    required String text,
    required _i1.Vector embedding,
    DateTime? createdAt,
  }) = _SemanticChunkImpl;

  factory SemanticChunk.fromJson(Map<String, dynamic> jsonSerialization) {
    return SemanticChunk(
      id: jsonSerialization['id'] as int?,
      transcriptId: jsonSerialization['transcriptId'] as int,
      transcript: jsonSerialization['transcript'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Transcript>(
              jsonSerialization['transcript'],
            ),
      podcastId: jsonSerialization['podcastId'] as int,
      podcast: jsonSerialization['podcast'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Podcast>(
              jsonSerialization['podcast'],
            ),
      startTime: (jsonSerialization['startTime'] as num).toDouble(),
      endTime: (jsonSerialization['endTime'] as num).toDouble(),
      text: jsonSerialization['text'] as String,
      embedding: _i1.VectorJsonExtension.fromJson(
        jsonSerialization['embedding'],
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int transcriptId;

  /// The transcript this chunk came from
  _i2.Transcript? transcript;

  int podcastId;

  /// The podcast this chunk belongs to
  _i3.Podcast? podcast;

  /// Start timestamp in seconds
  double startTime;

  /// End timestamp in seconds
  double endTime;

  /// The text content of this chunk
  String text;

  /// The embedding vector (768 dimensions)
  _i1.Vector embedding;

  /// When this chunk was created
  DateTime createdAt;

  /// Returns a shallow copy of this [SemanticChunk]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SemanticChunk copyWith({
    int? id,
    int? transcriptId,
    _i2.Transcript? transcript,
    int? podcastId,
    _i3.Podcast? podcast,
    double? startTime,
    double? endTime,
    String? text,
    _i1.Vector? embedding,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SemanticChunk',
      if (id != null) 'id': id,
      'transcriptId': transcriptId,
      if (transcript != null) 'transcript': transcript?.toJson(),
      'podcastId': podcastId,
      if (podcast != null) 'podcast': podcast?.toJson(),
      'startTime': startTime,
      'endTime': endTime,
      'text': text,
      'embedding': embedding.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SemanticChunkImpl extends SemanticChunk {
  _SemanticChunkImpl({
    int? id,
    required int transcriptId,
    _i2.Transcript? transcript,
    required int podcastId,
    _i3.Podcast? podcast,
    required double startTime,
    required double endTime,
    required String text,
    required _i1.Vector embedding,
    DateTime? createdAt,
  }) : super._(
         id: id,
         transcriptId: transcriptId,
         transcript: transcript,
         podcastId: podcastId,
         podcast: podcast,
         startTime: startTime,
         endTime: endTime,
         text: text,
         embedding: embedding,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [SemanticChunk]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SemanticChunk copyWith({
    Object? id = _Undefined,
    int? transcriptId,
    Object? transcript = _Undefined,
    int? podcastId,
    Object? podcast = _Undefined,
    double? startTime,
    double? endTime,
    String? text,
    _i1.Vector? embedding,
    DateTime? createdAt,
  }) {
    return SemanticChunk(
      id: id is int? ? id : this.id,
      transcriptId: transcriptId ?? this.transcriptId,
      transcript: transcript is _i2.Transcript?
          ? transcript
          : this.transcript?.copyWith(),
      podcastId: podcastId ?? this.podcastId,
      podcast: podcast is _i3.Podcast? ? podcast : this.podcast?.copyWith(),
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      text: text ?? this.text,
      embedding: embedding ?? this.embedding.clone(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
