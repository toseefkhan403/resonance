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
import 'timestamp_reference.dart' as _i2;
import 'package:resonance_server/src/generated/protocol.dart' as _i3;

abstract class ConversationResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ConversationResponse._({
    required this.answer,
    required this.speakers,
    required this.sourceSubtopics,
    required this.citations,
  });

  factory ConversationResponse({
    required String answer,
    required List<String> speakers,
    required List<String> sourceSubtopics,
    required List<_i2.TimestampReference> citations,
  }) = _ConversationResponseImpl;

  factory ConversationResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ConversationResponse(
      answer: jsonSerialization['answer'] as String,
      speakers: _i3.Protocol().deserialize<List<String>>(
        jsonSerialization['speakers'],
      ),
      sourceSubtopics: _i3.Protocol().deserialize<List<String>>(
        jsonSerialization['sourceSubtopics'],
      ),
      citations: _i3.Protocol().deserialize<List<_i2.TimestampReference>>(
        jsonSerialization['citations'],
      ),
    );
  }

  /// The answer text
  String answer;

  /// The speaker(s) whose perspective this answer reflects
  List<String> speakers;

  /// Source subtopics used to generate this answer
  List<String> sourceSubtopics;

  /// Citations to specific podcast timestamps
  List<_i2.TimestampReference> citations;

  /// Returns a shallow copy of this [ConversationResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ConversationResponse copyWith({
    String? answer,
    List<String>? speakers,
    List<String>? sourceSubtopics,
    List<_i2.TimestampReference>? citations,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ConversationResponse',
      'answer': answer,
      'speakers': speakers.toJson(),
      'sourceSubtopics': sourceSubtopics.toJson(),
      'citations': citations.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ConversationResponse',
      'answer': answer,
      'speakers': speakers.toJson(),
      'sourceSubtopics': sourceSubtopics.toJson(),
      'citations': citations.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ConversationResponseImpl extends ConversationResponse {
  _ConversationResponseImpl({
    required String answer,
    required List<String> speakers,
    required List<String> sourceSubtopics,
    required List<_i2.TimestampReference> citations,
  }) : super._(
         answer: answer,
         speakers: speakers,
         sourceSubtopics: sourceSubtopics,
         citations: citations,
       );

  /// Returns a shallow copy of this [ConversationResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ConversationResponse copyWith({
    String? answer,
    List<String>? speakers,
    List<String>? sourceSubtopics,
    List<_i2.TimestampReference>? citations,
  }) {
    return ConversationResponse(
      answer: answer ?? this.answer,
      speakers: speakers ?? this.speakers.map((e0) => e0).toList(),
      sourceSubtopics:
          sourceSubtopics ?? this.sourceSubtopics.map((e0) => e0).toList(),
      citations:
          citations ?? this.citations.map((e0) => e0.copyWith()).toList(),
    );
  }
}
