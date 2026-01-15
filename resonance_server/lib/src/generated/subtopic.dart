/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'category.dart' as _i2;
import 'package:resonance_server/src/generated/protocol.dart' as _i3;

abstract class Subtopic
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = SubtopicTable();

  static const db = SubtopicRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Subtopic',
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
      'categoryId': categoryId,
      if (category != null) 'category': category?.toJsonForProtocol(),
      'secondaryConcepts': secondaryConcepts.toJson(),
      'summary': summary,
      'embedding': embedding.toJson(),
      'importanceScore': importanceScore,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SubtopicInclude include({_i2.CategoryInclude? category}) {
    return SubtopicInclude._(category: category);
  }

  static SubtopicIncludeList includeList({
    _i1.WhereExpressionBuilder<SubtopicTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtopicTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtopicTable>? orderByList,
    SubtopicInclude? include,
  }) {
    return SubtopicIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Subtopic.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Subtopic.t),
      include: include,
    );
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

class SubtopicUpdateTable extends _i1.UpdateTable<SubtopicTable> {
  SubtopicUpdateTable(super.table);

  _i1.ColumnValue<String, String> userId(String value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<int, int> categoryId(int value) => _i1.ColumnValue(
    table.categoryId,
    value,
  );

  _i1.ColumnValue<List<String>, List<String>> secondaryConcepts(
    List<String> value,
  ) => _i1.ColumnValue(
    table.secondaryConcepts,
    value,
  );

  _i1.ColumnValue<String, String> summary(String value) => _i1.ColumnValue(
    table.summary,
    value,
  );

  _i1.ColumnValue<_i1.Vector, _i1.Vector> embedding(_i1.Vector value) =>
      _i1.ColumnValue(
        table.embedding,
        value,
      );

  _i1.ColumnValue<double, double> importanceScore(double value) =>
      _i1.ColumnValue(
        table.importanceScore,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class SubtopicTable extends _i1.Table<int?> {
  SubtopicTable({super.tableRelation}) : super(tableName: 'subtopic') {
    updateTable = SubtopicUpdateTable(this);
    userId = _i1.ColumnString(
      'userId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    categoryId = _i1.ColumnInt(
      'categoryId',
      this,
    );
    secondaryConcepts = _i1.ColumnSerializable<List<String>>(
      'secondaryConcepts',
      this,
    );
    summary = _i1.ColumnString(
      'summary',
      this,
    );
    embedding = _i1.ColumnVector(
      'embedding',
      this,
      dimension: 768,
    );
    importanceScore = _i1.ColumnDouble(
      'importanceScore',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final SubtopicUpdateTable updateTable;

  /// The user who owns this subtopic
  late final _i1.ColumnString userId;

  /// The canonical name (short noun phrase)
  late final _i1.ColumnString name;

  late final _i1.ColumnInt categoryId;

  /// The category this subtopic belongs to
  _i2.CategoryTable? _category;

  /// Secondary concepts (stored as JSON list)
  late final _i1.ColumnSerializable<List<String>> secondaryConcepts;

  /// A concise human-readable summary
  late final _i1.ColumnString summary;

  /// The embedding vector for this subtopic (for similarity matching, 768 dimensions)
  late final _i1.ColumnVector embedding;

  /// Importance score (0.0 to 1.0)
  late final _i1.ColumnDouble importanceScore;

  /// When the subtopic was created
  late final _i1.ColumnDateTime createdAt;

  /// When the subtopic was last updated
  late final _i1.ColumnDateTime updatedAt;

  _i2.CategoryTable get category {
    if (_category != null) return _category!;
    _category = _i1.createRelationTable(
      relationFieldName: 'category',
      field: Subtopic.t.categoryId,
      foreignField: _i2.Category.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CategoryTable(tableRelation: foreignTableRelation),
    );
    return _category!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    name,
    categoryId,
    secondaryConcepts,
    summary,
    embedding,
    importanceScore,
    createdAt,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'category') {
      return category;
    }
    return null;
  }
}

class SubtopicInclude extends _i1.IncludeObject {
  SubtopicInclude._({_i2.CategoryInclude? category}) {
    _category = category;
  }

  _i2.CategoryInclude? _category;

  @override
  Map<String, _i1.Include?> get includes => {'category': _category};

  @override
  _i1.Table<int?> get table => Subtopic.t;
}

class SubtopicIncludeList extends _i1.IncludeList {
  SubtopicIncludeList._({
    _i1.WhereExpressionBuilder<SubtopicTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Subtopic.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Subtopic.t;
}

class SubtopicRepository {
  const SubtopicRepository._();

  final attachRow = const SubtopicAttachRowRepository._();

  /// Returns a list of [Subtopic]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Subtopic>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubtopicTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtopicTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtopicTable>? orderByList,
    _i1.Transaction? transaction,
    SubtopicInclude? include,
  }) async {
    return session.db.find<Subtopic>(
      where: where?.call(Subtopic.t),
      orderBy: orderBy?.call(Subtopic.t),
      orderByList: orderByList?.call(Subtopic.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Subtopic] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Subtopic?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubtopicTable>? where,
    int? offset,
    _i1.OrderByBuilder<SubtopicTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtopicTable>? orderByList,
    _i1.Transaction? transaction,
    SubtopicInclude? include,
  }) async {
    return session.db.findFirstRow<Subtopic>(
      where: where?.call(Subtopic.t),
      orderBy: orderBy?.call(Subtopic.t),
      orderByList: orderByList?.call(Subtopic.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Subtopic] by its [id] or null if no such row exists.
  Future<Subtopic?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    SubtopicInclude? include,
  }) async {
    return session.db.findById<Subtopic>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Subtopic]s in the list and returns the inserted rows.
  ///
  /// The returned [Subtopic]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Subtopic>> insert(
    _i1.Session session,
    List<Subtopic> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Subtopic>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Subtopic] and returns the inserted row.
  ///
  /// The returned [Subtopic] will have its `id` field set.
  Future<Subtopic> insertRow(
    _i1.Session session,
    Subtopic row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Subtopic>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Subtopic]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Subtopic>> update(
    _i1.Session session,
    List<Subtopic> rows, {
    _i1.ColumnSelections<SubtopicTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Subtopic>(
      rows,
      columns: columns?.call(Subtopic.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Subtopic]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Subtopic> updateRow(
    _i1.Session session,
    Subtopic row, {
    _i1.ColumnSelections<SubtopicTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Subtopic>(
      row,
      columns: columns?.call(Subtopic.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Subtopic] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Subtopic?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<SubtopicUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Subtopic>(
      id,
      columnValues: columnValues(Subtopic.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Subtopic]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Subtopic>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<SubtopicUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SubtopicTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtopicTable>? orderBy,
    _i1.OrderByListBuilder<SubtopicTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Subtopic>(
      columnValues: columnValues(Subtopic.t.updateTable),
      where: where(Subtopic.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Subtopic.t),
      orderByList: orderByList?.call(Subtopic.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Subtopic]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Subtopic>> delete(
    _i1.Session session,
    List<Subtopic> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Subtopic>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Subtopic].
  Future<Subtopic> deleteRow(
    _i1.Session session,
    Subtopic row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Subtopic>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Subtopic>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SubtopicTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Subtopic>(
      where: where(Subtopic.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubtopicTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Subtopic>(
      where: where?.call(Subtopic.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class SubtopicAttachRowRepository {
  const SubtopicAttachRowRepository._();

  /// Creates a relation between the given [Subtopic] and [Category]
  /// by setting the [Subtopic]'s foreign key `categoryId` to refer to the [Category].
  Future<void> category(
    _i1.Session session,
    Subtopic subtopic,
    _i2.Category category, {
    _i1.Transaction? transaction,
  }) async {
    if (subtopic.id == null) {
      throw ArgumentError.notNull('subtopic.id');
    }
    if (category.id == null) {
      throw ArgumentError.notNull('category.id');
    }

    var $subtopic = subtopic.copyWith(categoryId: category.id);
    await session.db.updateRow<Subtopic>(
      $subtopic,
      columns: [Subtopic.t.categoryId],
      transaction: transaction,
    );
  }
}
