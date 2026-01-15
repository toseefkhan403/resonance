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

abstract class GraphLink
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  GraphLink._({
    required this.source,
    required this.target,
    required this.weight,
    required this.relationType,
  });

  factory GraphLink({
    required int source,
    required int target,
    required double weight,
    required String relationType,
  }) = _GraphLinkImpl;

  factory GraphLink.fromJson(Map<String, dynamic> jsonSerialization) {
    return GraphLink(
      source: jsonSerialization['source'] as int,
      target: jsonSerialization['target'] as int,
      weight: (jsonSerialization['weight'] as num).toDouble(),
      relationType: jsonSerialization['relationType'] as String,
    );
  }

  /// Source node ID
  int source;

  /// Target node ID
  int target;

  /// Weight of the relationship
  double weight;

  /// Relation type
  String relationType;

  /// Returns a shallow copy of this [GraphLink]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GraphLink copyWith({
    int? source,
    int? target,
    double? weight,
    String? relationType,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GraphLink',
      'source': source,
      'target': target,
      'weight': weight,
      'relationType': relationType,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GraphLink',
      'source': source,
      'target': target,
      'weight': weight,
      'relationType': relationType,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _GraphLinkImpl extends GraphLink {
  _GraphLinkImpl({
    required int source,
    required int target,
    required double weight,
    required String relationType,
  }) : super._(
         source: source,
         target: target,
         weight: weight,
         relationType: relationType,
       );

  /// Returns a shallow copy of this [GraphLink]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GraphLink copyWith({
    int? source,
    int? target,
    double? weight,
    String? relationType,
  }) {
    return GraphLink(
      source: source ?? this.source,
      target: target ?? this.target,
      weight: weight ?? this.weight,
      relationType: relationType ?? this.relationType,
    );
  }
}
