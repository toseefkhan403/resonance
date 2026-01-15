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
import 'semantic_chunk.dart' as _i2;
import 'subtopic.dart' as _i3;
import 'package:resonance_client/src/protocol/protocol.dart' as _i4;

abstract class ChunkSubtopicMapping implements _i1.SerializableModel {
  ChunkSubtopicMapping._({
    this.id,
    required this.chunkId,
    this.chunk,
    required this.subtopicId,
    this.subtopic,
    double? confidence,
    DateTime? createdAt,
  }) : confidence = confidence ?? 0.5,
       createdAt = createdAt ?? DateTime.now();

  factory ChunkSubtopicMapping({
    int? id,
    required int chunkId,
    _i2.SemanticChunk? chunk,
    required int subtopicId,
    _i3.Subtopic? subtopic,
    double? confidence,
    DateTime? createdAt,
  }) = _ChunkSubtopicMappingImpl;

  factory ChunkSubtopicMapping.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ChunkSubtopicMapping(
      id: jsonSerialization['id'] as int?,
      chunkId: jsonSerialization['chunkId'] as int,
      chunk: jsonSerialization['chunk'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.SemanticChunk>(
              jsonSerialization['chunk'],
            ),
      subtopicId: jsonSerialization['subtopicId'] as int,
      subtopic: jsonSerialization['subtopic'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Subtopic>(
              jsonSerialization['subtopic'],
            ),
      confidence: (jsonSerialization['confidence'] as num?)?.toDouble(),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int chunkId;

  /// The semantic chunk
  _i2.SemanticChunk? chunk;

  int subtopicId;

  /// The subtopic
  _i3.Subtopic? subtopic;

  /// Confidence score (0.0 to 1.0) for this mapping
  double confidence;

  /// When this mapping was created
  DateTime createdAt;

  /// Returns a shallow copy of this [ChunkSubtopicMapping]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChunkSubtopicMapping copyWith({
    int? id,
    int? chunkId,
    _i2.SemanticChunk? chunk,
    int? subtopicId,
    _i3.Subtopic? subtopic,
    double? confidence,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChunkSubtopicMapping',
      if (id != null) 'id': id,
      'chunkId': chunkId,
      if (chunk != null) 'chunk': chunk?.toJson(),
      'subtopicId': subtopicId,
      if (subtopic != null) 'subtopic': subtopic?.toJson(),
      'confidence': confidence,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChunkSubtopicMappingImpl extends ChunkSubtopicMapping {
  _ChunkSubtopicMappingImpl({
    int? id,
    required int chunkId,
    _i2.SemanticChunk? chunk,
    required int subtopicId,
    _i3.Subtopic? subtopic,
    double? confidence,
    DateTime? createdAt,
  }) : super._(
         id: id,
         chunkId: chunkId,
         chunk: chunk,
         subtopicId: subtopicId,
         subtopic: subtopic,
         confidence: confidence,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ChunkSubtopicMapping]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChunkSubtopicMapping copyWith({
    Object? id = _Undefined,
    int? chunkId,
    Object? chunk = _Undefined,
    int? subtopicId,
    Object? subtopic = _Undefined,
    double? confidence,
    DateTime? createdAt,
  }) {
    return ChunkSubtopicMapping(
      id: id is int? ? id : this.id,
      chunkId: chunkId ?? this.chunkId,
      chunk: chunk is _i2.SemanticChunk? ? chunk : this.chunk?.copyWith(),
      subtopicId: subtopicId ?? this.subtopicId,
      subtopic: subtopic is _i3.Subtopic?
          ? subtopic
          : this.subtopic?.copyWith(),
      confidence: confidence ?? this.confidence,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
