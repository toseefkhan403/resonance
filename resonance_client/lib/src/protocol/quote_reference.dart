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

abstract class QuoteReference implements _i1.SerializableModel {
  QuoteReference._({
    required this.startTime,
    required this.endTime,
    required this.verbatimQuote,
  });

  factory QuoteReference({
    required double startTime,
    required double endTime,
    required String verbatimQuote,
  }) = _QuoteReferenceImpl;

  factory QuoteReference.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuoteReference(
      startTime: (jsonSerialization['startTime'] as num).toDouble(),
      endTime: (jsonSerialization['endTime'] as num).toDouble(),
      verbatimQuote: jsonSerialization['verbatimQuote'] as String,
    );
  }

  double startTime;

  double endTime;

  String verbatimQuote;

  /// Returns a shallow copy of this [QuoteReference]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QuoteReference copyWith({
    double? startTime,
    double? endTime,
    String? verbatimQuote,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuoteReference',
      'startTime': startTime,
      'endTime': endTime,
      'verbatimQuote': verbatimQuote,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _QuoteReferenceImpl extends QuoteReference {
  _QuoteReferenceImpl({
    required double startTime,
    required double endTime,
    required String verbatimQuote,
  }) : super._(
         startTime: startTime,
         endTime: endTime,
         verbatimQuote: verbatimQuote,
       );

  /// Returns a shallow copy of this [QuoteReference]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QuoteReference copyWith({
    double? startTime,
    double? endTime,
    String? verbatimQuote,
  }) {
    return QuoteReference(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      verbatimQuote: verbatimQuote ?? this.verbatimQuote,
    );
  }
}
