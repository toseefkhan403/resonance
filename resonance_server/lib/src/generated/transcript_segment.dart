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

abstract class TranscriptSegment
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  TranscriptSegment._({
    required this.start,
    required this.duration,
    required this.text,
  });

  factory TranscriptSegment({
    required double start,
    required double duration,
    required String text,
  }) = _TranscriptSegmentImpl;

  factory TranscriptSegment.fromJson(Map<String, dynamic> jsonSerialization) {
    return TranscriptSegment(
      start: (jsonSerialization['start'] as num).toDouble(),
      duration: (jsonSerialization['duration'] as num).toDouble(),
      text: jsonSerialization['text'] as String,
    );
  }

  /// Start time in seconds
  double start;

  /// Duration in seconds
  double duration;

  /// The text content
  String text;

  /// Returns a shallow copy of this [TranscriptSegment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TranscriptSegment copyWith({
    double? start,
    double? duration,
    String? text,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TranscriptSegment',
      'start': start,
      'duration': duration,
      'text': text,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TranscriptSegment',
      'start': start,
      'duration': duration,
      'text': text,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _TranscriptSegmentImpl extends TranscriptSegment {
  _TranscriptSegmentImpl({
    required double start,
    required double duration,
    required String text,
  }) : super._(
         start: start,
         duration: duration,
         text: text,
       );

  /// Returns a shallow copy of this [TranscriptSegment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TranscriptSegment copyWith({
    double? start,
    double? duration,
    String? text,
  }) {
    return TranscriptSegment(
      start: start ?? this.start,
      duration: duration ?? this.duration,
      text: text ?? this.text,
    );
  }
}
