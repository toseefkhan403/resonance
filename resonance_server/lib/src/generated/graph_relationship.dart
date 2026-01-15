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
import 'package:resonance_server/src/generated/protocol.dart' as _i2;

abstract class GraphRelationship
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = GraphRelationshipTable();

  static const db = GraphRelationshipRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static GraphRelationshipInclude include() {
    return GraphRelationshipInclude._();
  }

  static GraphRelationshipIncludeList includeList({
    _i1.WhereExpressionBuilder<GraphRelationshipTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GraphRelationshipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GraphRelationshipTable>? orderByList,
    GraphRelationshipInclude? include,
  }) {
    return GraphRelationshipIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GraphRelationship.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(GraphRelationship.t),
      include: include,
    );
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

class GraphRelationshipUpdateTable
    extends _i1.UpdateTable<GraphRelationshipTable> {
  GraphRelationshipUpdateTable(super.table);

  _i1.ColumnValue<String, String> userId(String value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> sourceId(int value) => _i1.ColumnValue(
    table.sourceId,
    value,
  );

  _i1.ColumnValue<String, String> sourceType(String value) => _i1.ColumnValue(
    table.sourceType,
    value,
  );

  _i1.ColumnValue<int, int> targetId(int value) => _i1.ColumnValue(
    table.targetId,
    value,
  );

  _i1.ColumnValue<String, String> targetType(String value) => _i1.ColumnValue(
    table.targetType,
    value,
  );

  _i1.ColumnValue<String, String> relationType(String value) => _i1.ColumnValue(
    table.relationType,
    value,
  );

  _i1.ColumnValue<double, double> weight(double value) => _i1.ColumnValue(
    table.weight,
    value,
  );

  _i1.ColumnValue<Map<String, String>, Map<String, String>> metadata(
    Map<String, String>? value,
  ) => _i1.ColumnValue(
    table.metadata,
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

class GraphRelationshipTable extends _i1.Table<int?> {
  GraphRelationshipTable({super.tableRelation})
    : super(tableName: 'graph_relationship') {
    updateTable = GraphRelationshipUpdateTable(this);
    userId = _i1.ColumnString(
      'userId',
      this,
    );
    sourceId = _i1.ColumnInt(
      'sourceId',
      this,
    );
    sourceType = _i1.ColumnString(
      'sourceType',
      this,
    );
    targetId = _i1.ColumnInt(
      'targetId',
      this,
    );
    targetType = _i1.ColumnString(
      'targetType',
      this,
    );
    relationType = _i1.ColumnString(
      'relationType',
      this,
    );
    weight = _i1.ColumnDouble(
      'weight',
      this,
      hasDefault: true,
    );
    metadata = _i1.ColumnSerializable<Map<String, String>>(
      'metadata',
      this,
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

  late final GraphRelationshipUpdateTable updateTable;

  /// The user who owns this relationship
  late final _i1.ColumnString userId;

  /// Source node ID (can be category or subtopic)
  late final _i1.ColumnInt sourceId;

  /// Source node type: category or subtopic
  late final _i1.ColumnString sourceType;

  /// Target node ID (can be category or subtopic)
  late final _i1.ColumnInt targetId;

  /// Target node type: category or subtopic
  late final _i1.ColumnString targetType;

  /// Relationship type: membership, similarity, cooccurrence, provenance
  late final _i1.ColumnString relationType;

  /// Weight/strength of the relationship (0.0 to 1.0)
  late final _i1.ColumnDouble weight;

  /// Additional metadata (stored as JSON)
  late final _i1.ColumnSerializable<Map<String, String>> metadata;

  /// When this relationship was created
  late final _i1.ColumnDateTime createdAt;

  /// When this relationship was last updated
  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    sourceId,
    sourceType,
    targetId,
    targetType,
    relationType,
    weight,
    metadata,
    createdAt,
    updatedAt,
  ];
}

class GraphRelationshipInclude extends _i1.IncludeObject {
  GraphRelationshipInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => GraphRelationship.t;
}

class GraphRelationshipIncludeList extends _i1.IncludeList {
  GraphRelationshipIncludeList._({
    _i1.WhereExpressionBuilder<GraphRelationshipTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(GraphRelationship.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => GraphRelationship.t;
}

class GraphRelationshipRepository {
  const GraphRelationshipRepository._();

  /// Returns a list of [GraphRelationship]s matching the given query parameters.
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
  Future<List<GraphRelationship>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GraphRelationshipTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GraphRelationshipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GraphRelationshipTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<GraphRelationship>(
      where: where?.call(GraphRelationship.t),
      orderBy: orderBy?.call(GraphRelationship.t),
      orderByList: orderByList?.call(GraphRelationship.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [GraphRelationship] matching the given query parameters.
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
  Future<GraphRelationship?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GraphRelationshipTable>? where,
    int? offset,
    _i1.OrderByBuilder<GraphRelationshipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GraphRelationshipTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<GraphRelationship>(
      where: where?.call(GraphRelationship.t),
      orderBy: orderBy?.call(GraphRelationship.t),
      orderByList: orderByList?.call(GraphRelationship.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [GraphRelationship] by its [id] or null if no such row exists.
  Future<GraphRelationship?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<GraphRelationship>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [GraphRelationship]s in the list and returns the inserted rows.
  ///
  /// The returned [GraphRelationship]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<GraphRelationship>> insert(
    _i1.Session session,
    List<GraphRelationship> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<GraphRelationship>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [GraphRelationship] and returns the inserted row.
  ///
  /// The returned [GraphRelationship] will have its `id` field set.
  Future<GraphRelationship> insertRow(
    _i1.Session session,
    GraphRelationship row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<GraphRelationship>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [GraphRelationship]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<GraphRelationship>> update(
    _i1.Session session,
    List<GraphRelationship> rows, {
    _i1.ColumnSelections<GraphRelationshipTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<GraphRelationship>(
      rows,
      columns: columns?.call(GraphRelationship.t),
      transaction: transaction,
    );
  }

  /// Updates a single [GraphRelationship]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<GraphRelationship> updateRow(
    _i1.Session session,
    GraphRelationship row, {
    _i1.ColumnSelections<GraphRelationshipTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<GraphRelationship>(
      row,
      columns: columns?.call(GraphRelationship.t),
      transaction: transaction,
    );
  }

  /// Updates a single [GraphRelationship] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<GraphRelationship?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<GraphRelationshipUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<GraphRelationship>(
      id,
      columnValues: columnValues(GraphRelationship.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [GraphRelationship]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<GraphRelationship>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<GraphRelationshipUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<GraphRelationshipTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GraphRelationshipTable>? orderBy,
    _i1.OrderByListBuilder<GraphRelationshipTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<GraphRelationship>(
      columnValues: columnValues(GraphRelationship.t.updateTable),
      where: where(GraphRelationship.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GraphRelationship.t),
      orderByList: orderByList?.call(GraphRelationship.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [GraphRelationship]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<GraphRelationship>> delete(
    _i1.Session session,
    List<GraphRelationship> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<GraphRelationship>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [GraphRelationship].
  Future<GraphRelationship> deleteRow(
    _i1.Session session,
    GraphRelationship row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<GraphRelationship>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<GraphRelationship>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<GraphRelationshipTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<GraphRelationship>(
      where: where(GraphRelationship.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GraphRelationshipTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<GraphRelationship>(
      where: where?.call(GraphRelationship.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
