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

abstract class TimestampReference
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  TimestampReference._({
    required this.podcastId,
    required this.youtubeUrl,
    required this.startTime,
    required this.endTime,
    required this.previewText,
  });

  factory TimestampReference({
    required int podcastId,
    required String youtubeUrl,
    required double startTime,
    required double endTime,
    required String previewText,
  }) = _TimestampReferenceImpl;

  factory TimestampReference.fromJson(Map<String, dynamic> jsonSerialization) {
    return TimestampReference(
      podcastId: jsonSerialization['podcastId'] as int,
      youtubeUrl: jsonSerialization['youtubeUrl'] as String,
      startTime: (jsonSerialization['startTime'] as num).toDouble(),
      endTime: (jsonSerialization['endTime'] as num).toDouble(),
      previewText: jsonSerialization['previewText'] as String,
    );
  }

  /// Podcast ID
  int podcastId;

  /// YouTube URL
  String youtubeUrl;

  /// Start time in seconds
  double startTime;

  /// End time in seconds
  double endTime;

  /// Preview text
  String previewText;

  /// Returns a shallow copy of this [TimestampReference]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TimestampReference copyWith({
    int? podcastId,
    String? youtubeUrl,
    double? startTime,
    double? endTime,
    String? previewText,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TimestampReference',
      'podcastId': podcastId,
      'youtubeUrl': youtubeUrl,
      'startTime': startTime,
      'endTime': endTime,
      'previewText': previewText,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TimestampReference',
      'podcastId': podcastId,
      'youtubeUrl': youtubeUrl,
      'startTime': startTime,
      'endTime': endTime,
      'previewText': previewText,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _TimestampReferenceImpl extends TimestampReference {
  _TimestampReferenceImpl({
    required int podcastId,
    required String youtubeUrl,
    required double startTime,
    required double endTime,
    required String previewText,
  }) : super._(
         podcastId: podcastId,
         youtubeUrl: youtubeUrl,
         startTime: startTime,
         endTime: endTime,
         previewText: previewText,
       );

  /// Returns a shallow copy of this [TimestampReference]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TimestampReference copyWith({
    int? podcastId,
    String? youtubeUrl,
    double? startTime,
    double? endTime,
    String? previewText,
  }) {
    return TimestampReference(
      podcastId: podcastId ?? this.podcastId,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      previewText: previewText ?? this.previewText,
    );
  }
}
