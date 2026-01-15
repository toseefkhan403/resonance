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
import 'package:resonance_client/src/protocol/protocol.dart' as _i2;

abstract class GraphRelationship implements _i1.SerializableModel {
  GraphRelationship._({
    this.id,
    required this.userId,
    required this.sourceId,
    required this.sourceType,
    required this.targetId,
    required this.targetType,
    required this.relationType,
    double? weight,
    this.metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : weight = weight ?? 0.5,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory GraphRelationship({
    int? id,
    required String userId,
    required int sourceId,
    required String sourceType,
    required int targetId,
    required String targetType,
    required String relationType,
    double? weight,
    Map<String, String>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _GraphRelationshipImpl;

  factory GraphRelationship.fromJson(Map<String, dynamic> jsonSerialization) {
    return GraphRelationship(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      sourceId: jsonSerialization['sourceId'] as int,
      sourceType: jsonSerialization['sourceType'] as String,
      targetId: jsonSerialization['targetId'] as int,
      targetType: jsonSerialization['targetType'] as String,
      relationType: jsonSerialization['relationType'] as String,
      weight: (jsonSerialization['weight'] as num?)?.toDouble(),
      metadata: jsonSerialization['metadata'] == null
          ? null
          : _i2.Protocol().deserialize<Map<String, String>>(
              jsonSerialization['metadata'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// The user who owns this relationship
  String userId;

  /// Source node ID (can be category or subtopic)
  int sourceId;

  /// Source node type: category or subtopic
  String sourceType;

  /// Target node ID (can be category or subtopic)
  int targetId;

  /// Target node type: category or subtopic
  String targetType;

  /// Relationship type: membership, similarity, cooccurrence, provenance
  String relationType;

  /// Weight/strength of the relationship (0.0 to 1.0)
  double weight;

  /// Additional metadata (stored as JSON)
  Map<String, String>? metadata;

  /// When this relationship was created
  DateTime createdAt;

  /// When this relationship was last updated
  DateTime updatedAt;

  /// Returns a shallow copy of this [GraphRelationship]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GraphRelationship copyWith({
    int? id,
    String? userId,
    int? sourceId,
    String? sourceType,
    int? targetId,
    String? targetType,
    String? relationType,
    double? weight,
    Map<String, String>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GraphRelationship',
      if (id != null) 'id': id,
      'userId': userId,
      'sourceId': sourceId,
      'sourceType': sourceType,
      'targetId': targetId,
      'targetType': targetType,
      'relationType': relationType,
      'weight': weight,
      if (metadata != null) 'metadata': metadata?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GraphRelationshipImpl extends GraphRelationship {
  _GraphRelationshipImpl({
    int? id,
    required String userId,
    required int sourceId,
    required String sourceType,
    required int targetId,
    required String targetType,
    required String relationType,
    double? weight,
    Map<String, String>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         sourceId: sourceId,
         sourceType: sourceType,
         targetId: targetId,
         targetType: targetType,
         relationType: relationType,
         weight: weight,
         metadata: metadata,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [GraphRelationship]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GraphRelationship copyWith({
    Object? id = _Undefined,
    String? userId,
    int? sourceId,
    String? sourceType,
    int? targetId,
    String? targetType,
    String? relationType,
    double? weight,
    Object? metadata = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GraphRelationship(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      sourceId: sourceId ?? this.sourceId,
      sourceType: sourceType ?? this.sourceType,
      targetId: targetId ?? this.targetId,
      targetType: targetType ?? this.targetType,
      relationType: relationType ?? this.relationType,
      weight: weight ?? this.weight,
      metadata: metadata is Map<String, String>?
          ? metadata
          : this.metadata?.map(
              (
                key0,
                value0,
              ) => MapEntry(
                key0,
                value0,
              ),
            ),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
