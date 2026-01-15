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

abstract class GraphNode
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  GraphNode._({
    required this.id,
    required this.type,
    required this.label,
    this.category,
    required this.importanceScore,
    this.summary,
  });

  factory GraphNode({
    required int id,
    required String type,
    required String label,
    String? category,
    required double importanceScore,
    String? summary,
  }) = _GraphNodeImpl;

  factory GraphNode.fromJson(Map<String, dynamic> jsonSerialization) {
    return GraphNode(
      id: jsonSerialization['id'] as int,
      type: jsonSerialization['type'] as String,
      label: jsonSerialization['label'] as String,
      category: jsonSerialization['category'] as String?,
      importanceScore: (jsonSerialization['importanceScore'] as num).toDouble(),
      summary: jsonSerialization['summary'] as String?,
    );
  }

  /// Node ID (category or subtopic ID)
  int id;

  /// Node type: category or subtopic
  String type;

  /// Display label
  String label;

  /// Category name (for subtopics)
  String? category;

  /// Importance score
  double importanceScore;

  /// Summary (for subtopics)
  String? summary;

  /// Returns a shallow copy of this [GraphNode]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GraphNode copyWith({
    int? id,
    String? type,
    String? label,
    String? category,
    double? importanceScore,
    String? summary,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GraphNode',
      'id': id,
      'type': type,
      'label': label,
      if (category != null) 'category': category,
      'importanceScore': importanceScore,
      if (summary != null) 'summary': summary,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GraphNode',
      'id': id,
      'type': type,
      'label': label,
      if (category != null) 'category': category,
      'importanceScore': importanceScore,
      if (summary != null) 'summary': summary,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GraphNodeImpl extends GraphNode {
  _GraphNodeImpl({
    required int id,
    required String type,
    required String label,
    String? category,
    required double importanceScore,
    String? summary,
  }) : super._(
         id: id,
         type: type,
         label: label,
         category: category,
         importanceScore: importanceScore,
         summary: summary,
       );

  /// Returns a shallow copy of this [GraphNode]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GraphNode copyWith({
    int? id,
    String? type,
    String? label,
    Object? category = _Undefined,
    double? importanceScore,
    Object? summary = _Undefined,
  }) {
    return GraphNode(
      id: id ?? this.id,
      type: type ?? this.type,
      label: label ?? this.label,
      category: category is String? ? category : this.category,
      importanceScore: importanceScore ?? this.importanceScore,
      summary: summary is String? ? summary : this.summary,
    );
  }
}
