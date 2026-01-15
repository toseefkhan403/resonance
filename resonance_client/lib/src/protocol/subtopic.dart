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
import 'category.dart' as _i2;
import 'package:resonance_client/src/protocol/protocol.dart' as _i3;

abstract class Subtopic implements _i1.SerializableModel {
  Subtopic._({
    this.id,
    required this.userId,
    required this.name,
    required this.categoryId,
    this.category,
    required this.secondaryConcepts,
    required this.summary,
    required this.embedding,
    double? importanceScore,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : importanceScore = importanceScore ?? 0.5,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Subtopic({
    int? id,
    required String userId,
    required String name,
    required int categoryId,
    _i2.Category? category,
    required List<String> secondaryConcepts,
    required String summary,
    required _i1.Vector embedding,
    double? importanceScore,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SubtopicImpl;

  factory Subtopic.fromJson(Map<String, dynamic> jsonSerialization) {
    return Subtopic(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      name: jsonSerialization['name'] as String,
      categoryId: jsonSerialization['categoryId'] as int,
      category: jsonSerialization['category'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Category>(
              jsonSerialization['category'],
            ),
      secondaryConcepts: _i3.Protocol().deserialize<List<String>>(
        jsonSerialization['secondaryConcepts'],
      ),
      summary: jsonSerialization['summary'] as String,
      embedding: _i1.VectorJsonExtension.fromJson(
        jsonSerialization['embedding'],
      ),
      importanceScore: (jsonSerialization['importanceScore'] as num?)
          ?.toDouble(),
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

  /// The user who owns this subtopic
  String userId;

  /// The canonical name (short noun phrase)
  String name;

  int categoryId;

  /// The category this subtopic belongs to
  _i2.Category? category;

  /// Secondary concepts (stored as JSON list)
  List<String> secondaryConcepts;

  /// A concise human-readable summary
  String summary;

  /// The embedding vector for this subtopic (for similarity matching, 768 dimensions)
  _i1.Vector embedding;

  /// Importance score (0.0 to 1.0)
  double importanceScore;

  /// When the subtopic was created
  DateTime createdAt;

  /// When the subtopic was last updated
  DateTime updatedAt;

  /// Returns a shallow copy of this [Subtopic]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Subtopic copyWith({
    int? id,
    String? userId,
    String? name,
    int? categoryId,
    _i2.Category? category,
    List<String>? secondaryConcepts,
    String? summary,
    _i1.Vector? embedding,
    double? importanceScore,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Subtopic',
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
      'categoryId': categoryId,
      if (category != null) 'category': category?.toJson(),
      'secondaryConcepts': secondaryConcepts.toJson(),
      'summary': summary,
      'embedding': embedding.toJson(),
      'importanceScore': importanceScore,
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

class _SubtopicImpl extends Subtopic {
  _SubtopicImpl({
    int? id,
    required String userId,
    required String name,
    required int categoryId,
    _i2.Category? category,
    required List<String> secondaryConcepts,
    required String summary,
    required _i1.Vector embedding,
    double? importanceScore,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         name: name,
         categoryId: categoryId,
         category: category,
         secondaryConcepts: secondaryConcepts,
         summary: summary,
         embedding: embedding,
         importanceScore: importanceScore,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Subtopic]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Subtopic copyWith({
    Object? id = _Undefined,
    String? userId,
    String? name,
    int? categoryId,
    Object? category = _Undefined,
    List<String>? secondaryConcepts,
    String? summary,
    _i1.Vector? embedding,
    double? importanceScore,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Subtopic(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      category: category is _i2.Category?
          ? category
          : this.category?.copyWith(),
      secondaryConcepts:
          secondaryConcepts ?? this.secondaryConcepts.map((e0) => e0).toList(),
      summary: summary ?? this.summary,
      embedding: embedding ?? this.embedding.clone(),
      importanceScore: importanceScore ?? this.importanceScore,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
