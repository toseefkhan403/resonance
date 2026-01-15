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

abstract class PodcastReference
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  PodcastReference._({
    required this.podcastId,
    required this.youtubeUrl,
    this.title,
    required this.frequency,
  });

  factory PodcastReference({
    required int podcastId,
    required String youtubeUrl,
    String? title,
    required int frequency,
  }) = _PodcastReferenceImpl;

  factory PodcastReference.fromJson(Map<String, dynamic> jsonSerialization) {
    return PodcastReference(
      podcastId: jsonSerialization['podcastId'] as int,
      youtubeUrl: jsonSerialization['youtubeUrl'] as String,
      title: jsonSerialization['title'] as String?,
      frequency: jsonSerialization['frequency'] as int,
    );
  }

  /// Podcast ID
  int podcastId;

  /// YouTube URL
  String youtubeUrl;

  /// Title
  String? title;

  /// Frequency of this subtopic in the podcast
  int frequency;

  /// Returns a shallow copy of this [PodcastReference]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PodcastReference copyWith({
    int? podcastId,
    String? youtubeUrl,
    String? title,
    int? frequency,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PodcastReference',
      'podcastId': podcastId,
      'youtubeUrl': youtubeUrl,
      if (title != null) 'title': title,
      'frequency': frequency,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PodcastReference',
      'podcastId': podcastId,
      'youtubeUrl': youtubeUrl,
      if (title != null) 'title': title,
      'frequency': frequency,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PodcastReferenceImpl extends PodcastReference {
  _PodcastReferenceImpl({
    required int podcastId,
    required String youtubeUrl,
    String? title,
    required int frequency,
  }) : super._(
         podcastId: podcastId,
         youtubeUrl: youtubeUrl,
         title: title,
         frequency: frequency,
       );

  /// Returns a shallow copy of this [PodcastReference]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PodcastReference copyWith({
    int? podcastId,
    String? youtubeUrl,
    Object? title = _Undefined,
    int? frequency,
  }) {
    return PodcastReference(
      podcastId: podcastId ?? this.podcastId,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      title: title is String? ? title : this.title,
      frequency: frequency ?? this.frequency,
    );
  }
}
