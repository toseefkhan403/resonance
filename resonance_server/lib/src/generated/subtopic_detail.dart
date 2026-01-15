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
import 'package:serverpod/serverpod.dart' as _i1;
import 'podcast_reference.dart' as _i2;
import 'timestamp_reference.dart' as _i3;
import 'package:resonance_server/src/generated/protocol.dart' as _i4;

abstract class SubtopicDetail
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  SubtopicDetail._({
    required this.subtopicId,
    required this.name,
    this.category,
    required this.summary,
    required this.podcasts,
    required this.timestamps,
  });

  factory SubtopicDetail({
    required int subtopicId,
    required String name,
    String? category,
    required String summary,
    required List<_i2.PodcastReference> podcasts,
    required List<_i3.TimestampReference> timestamps,
  }) = _SubtopicDetailImpl;

  factory SubtopicDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubtopicDetail(
      subtopicId: jsonSerialization['subtopicId'] as int,
      name: jsonSerialization['name'] as String,
      category: jsonSerialization['category'] as String?,
      summary: jsonSerialization['summary'] as String,
      podcasts: _i4.Protocol().deserialize<List<_i2.PodcastReference>>(
        jsonSerialization['podcasts'],
      ),
      timestamps: _i4.Protocol().deserialize<List<_i3.TimestampReference>>(
        jsonSerialization['timestamps'],
      ),
    );
  }

  /// The subtopic ID
  int subtopicId;

  /// The subtopic name
  String name;

  /// The category
  String? category;

  /// The summary
  String summary;

  /// List of referenced podcasts with URLs
  List<_i2.PodcastReference> podcasts;

  /// List of exact timestamps that reference this subtopic
  List<_i3.TimestampReference> timestamps;

  /// Returns a shallow copy of this [SubtopicDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtopicDetail copyWith({
    int? subtopicId,
    String? name,
    String? category,
    String? summary,
    List<_i2.PodcastReference>? podcasts,
    List<_i3.TimestampReference>? timestamps,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtopicDetail',
      'subtopicId': subtopicId,
      'name': name,
      if (category != null) 'category': category,
      'summary': summary,
      'podcasts': podcasts.toJson(valueToJson: (v) => v.toJson()),
      'timestamps': timestamps.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SubtopicDetail',
      'subtopicId': subtopicId,
      'name': name,
      if (category != null) 'category': category,
      'summary': summary,
      'podcasts': podcasts.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'timestamps': timestamps.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubtopicDetailImpl extends SubtopicDetail {
  _SubtopicDetailImpl({
    required int subtopicId,
    required String name,
    String? category,
    required String summary,
    required List<_i2.PodcastReference> podcasts,
    required List<_i3.TimestampReference> timestamps,
  }) : super._(
         subtopicId: subtopicId,
         name: name,
         category: category,
         summary: summary,
         podcasts: podcasts,
         timestamps: timestamps,
       );

  /// Returns a shallow copy of this [SubtopicDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtopicDetail copyWith({
    int? subtopicId,
    String? name,
    Object? category = _Undefined,
    String? summary,
    List<_i2.PodcastReference>? podcasts,
    List<_i3.TimestampReference>? timestamps,
  }) {
    return SubtopicDetail(
      subtopicId: subtopicId ?? this.subtopicId,
      name: name ?? this.name,
      category: category is String? ? category : this.category,
      summary: summary ?? this.summary,
      podcasts: podcasts ?? this.podcasts.map((e0) => e0.copyWith()).toList(),
      timestamps:
          timestamps ?? this.timestamps.map((e0) => e0.copyWith()).toList(),
    );
  }
}
