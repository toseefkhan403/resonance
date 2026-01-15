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
import 'subtopic.dart' as _i3;
import 'package:resonance_client/src/protocol/protocol.dart' as _i4;

abstract class PodcastSubtopicEvidence implements _i1.SerializableModel {
  PodcastSubtopicEvidence._({
    this.id,
    required this.podcastId,
    this.podcast,
    required this.subtopicId,
    this.subtopic,
    int? frequency,
    DateTime? createdAt,
  }) : frequency = frequency ?? 1,
       createdAt = createdAt ?? DateTime.now();

  factory PodcastSubtopicEvidence({
    int? id,
    required int podcastId,
    _i2.Podcast? podcast,
    required int subtopicId,
    _i3.Subtopic? subtopic,
    int? frequency,
    DateTime? createdAt,
  }) = _PodcastSubtopicEvidenceImpl;

  factory PodcastSubtopicEvidence.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return PodcastSubtopicEvidence(
      id: jsonSerialization['id'] as int?,
      podcastId: jsonSerialization['podcastId'] as int,
      podcast: jsonSerialization['podcast'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Podcast>(
              jsonSerialization['podcast'],
            ),
      subtopicId: jsonSerialization['subtopicId'] as int,
      subtopic: jsonSerialization['subtopic'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Subtopic>(
              jsonSerialization['subtopic'],
            ),
      frequency: jsonSerialization['frequency'] as int?,
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

  /// The podcast
  _i2.Podcast? podcast;

  int subtopicId;

  /// The subtopic
  _i3.Subtopic? subtopic;

  /// Frequency count (how many times this subtopic appears in the podcast)
  int frequency;

  /// When this evidence was created
  DateTime createdAt;

  /// Returns a shallow copy of this [PodcastSubtopicEvidence]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PodcastSubtopicEvidence copyWith({
    int? id,
    int? podcastId,
    _i2.Podcast? podcast,
    int? subtopicId,
    _i3.Subtopic? subtopic,
    int? frequency,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PodcastSubtopicEvidence',
      if (id != null) 'id': id,
      'podcastId': podcastId,
      if (podcast != null) 'podcast': podcast?.toJson(),
      'subtopicId': subtopicId,
      if (subtopic != null) 'subtopic': subtopic?.toJson(),
      'frequency': frequency,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PodcastSubtopicEvidenceImpl extends PodcastSubtopicEvidence {
  _PodcastSubtopicEvidenceImpl({
    int? id,
    required int podcastId,
    _i2.Podcast? podcast,
    required int subtopicId,
    _i3.Subtopic? subtopic,
    int? frequency,
    DateTime? createdAt,
  }) : super._(
         id: id,
         podcastId: podcastId,
         podcast: podcast,
         subtopicId: subtopicId,
         subtopic: subtopic,
         frequency: frequency,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PodcastSubtopicEvidence]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PodcastSubtopicEvidence copyWith({
    Object? id = _Undefined,
    int? podcastId,
    Object? podcast = _Undefined,
    int? subtopicId,
    Object? subtopic = _Undefined,
    int? frequency,
    DateTime? createdAt,
  }) {
    return PodcastSubtopicEvidence(
      id: id is int? ? id : this.id,
      podcastId: podcastId ?? this.podcastId,
      podcast: podcast is _i2.Podcast? ? podcast : this.podcast?.copyWith(),
      subtopicId: subtopicId ?? this.subtopicId,
      subtopic: subtopic is _i3.Subtopic?
          ? subtopic
          : this.subtopic?.copyWith(),
      frequency: frequency ?? this.frequency,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
