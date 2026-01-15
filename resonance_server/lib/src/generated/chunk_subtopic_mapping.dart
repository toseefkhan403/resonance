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
import 'semantic_chunk.dart' as _i2;
import 'subtopic.dart' as _i3;
import 'package:resonance_server/src/generated/protocol.dart' as _i4;

abstract class ChunkSubtopicMapping
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = ChunkSubtopicMappingTable();

  static const db = ChunkSubtopicMappingRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChunkSubtopicMapping',
      if (id != null) 'id': id,
      'chunkId': chunkId,
      if (chunk != null) 'chunk': chunk?.toJsonForProtocol(),
      'subtopicId': subtopicId,
      if (subtopic != null) 'subtopic': subtopic?.toJsonForProtocol(),
      'confidence': confidence,
      'createdAt': createdAt.toJson(),
    };
  }

  static ChunkSubtopicMappingInclude include({
    _i2.SemanticChunkInclude? chunk,
    _i3.SubtopicInclude? subtopic,
  }) {
    return ChunkSubtopicMappingInclude._(
      chunk: chunk,
      subtopic: subtopic,
    );
  }

  static ChunkSubtopicMappingIncludeList includeList({
    _i1.WhereExpressionBuilder<ChunkSubtopicMappingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChunkSubtopicMappingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChunkSubtopicMappingTable>? orderByList,
    ChunkSubtopicMappingInclude? include,
  }) {
    return ChunkSubtopicMappingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChunkSubtopicMapping.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ChunkSubtopicMapping.t),
      include: include,
    );
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

class ChunkSubtopicMappingUpdateTable
    extends _i1.UpdateTable<ChunkSubtopicMappingTable> {
  ChunkSubtopicMappingUpdateTable(super.table);

  _i1.ColumnValue<int, int> chunkId(int value) => _i1.ColumnValue(
    table.chunkId,
    value,
  );

  _i1.ColumnValue<int, int> subtopicId(int value) => _i1.ColumnValue(
    table.subtopicId,
    value,
  );

  _i1.ColumnValue<double, double> confidence(double value) => _i1.ColumnValue(
    table.confidence,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class ChunkSubtopicMappingTable extends _i1.Table<int?> {
  ChunkSubtopicMappingTable({super.tableRelation})
    : super(tableName: 'chunk_subtopic_mapping') {
    updateTable = ChunkSubtopicMappingUpdateTable(this);
    chunkId = _i1.ColumnInt(
      'chunkId',
      this,
    );
    subtopicId = _i1.ColumnInt(
      'subtopicId',
      this,
    );
    confidence = _i1.ColumnDouble(
      'confidence',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final ChunkSubtopicMappingUpdateTable updateTable;

  late final _i1.ColumnInt chunkId;

  /// The semantic chunk
  _i2.SemanticChunkTable? _chunk;

  late final _i1.ColumnInt subtopicId;

  /// The subtopic
  _i3.SubtopicTable? _subtopic;

  /// Confidence score (0.0 to 1.0) for this mapping
  late final _i1.ColumnDouble confidence;

  /// When this mapping was created
  late final _i1.ColumnDateTime createdAt;

  _i2.SemanticChunkTable get chunk {
    if (_chunk != null) return _chunk!;
    _chunk = _i1.createRelationTable(
      relationFieldName: 'chunk',
      field: ChunkSubtopicMapping.t.chunkId,
      foreignField: _i2.SemanticChunk.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SemanticChunkTable(tableRelation: foreignTableRelation),
    );
    return _chunk!;
  }

  _i3.SubtopicTable get subtopic {
    if (_subtopic != null) return _subtopic!;
    _subtopic = _i1.createRelationTable(
      relationFieldName: 'subtopic',
      field: ChunkSubtopicMapping.t.subtopicId,
      foreignField: _i3.Subtopic.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.SubtopicTable(tableRelation: foreignTableRelation),
    );
    return _subtopic!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    chunkId,
    subtopicId,
    confidence,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'chunk') {
      return chunk;
    }
    if (relationField == 'subtopic') {
      return subtopic;
    }
    return null;
  }
}

class ChunkSubtopicMappingInclude extends _i1.IncludeObject {
  ChunkSubtopicMappingInclude._({
    _i2.SemanticChunkInclude? chunk,
    _i3.SubtopicInclude? subtopic,
  }) {
    _chunk = chunk;
    _subtopic = subtopic;
  }

  _i2.SemanticChunkInclude? _chunk;

  _i3.SubtopicInclude? _subtopic;

  @override
  Map<String, _i1.Include?> get includes => {
    'chunk': _chunk,
    'subtopic': _subtopic,
  };

  @override
  _i1.Table<int?> get table => ChunkSubtopicMapping.t;
}

class ChunkSubtopicMappingIncludeList extends _i1.IncludeList {
  ChunkSubtopicMappingIncludeList._({
    _i1.WhereExpressionBuilder<ChunkSubtopicMappingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ChunkSubtopicMapping.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ChunkSubtopicMapping.t;
}

class ChunkSubtopicMappingRepository {
  const ChunkSubtopicMappingRepository._();

  final attachRow = const ChunkSubtopicMappingAttachRowRepository._();

  /// Returns a list of [ChunkSubtopicMapping]s matching the given query parameters.
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
  Future<List<ChunkSubtopicMapping>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChunkSubtopicMappingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChunkSubtopicMappingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChunkSubtopicMappingTable>? orderByList,
    _i1.Transaction? transaction,
    ChunkSubtopicMappingInclude? include,
  }) async {
    return session.db.find<ChunkSubtopicMapping>(
      where: where?.call(ChunkSubtopicMapping.t),
      orderBy: orderBy?.call(ChunkSubtopicMapping.t),
      orderByList: orderByList?.call(ChunkSubtopicMapping.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [ChunkSubtopicMapping] matching the given query parameters.
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
  Future<ChunkSubtopicMapping?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChunkSubtopicMappingTable>? where,
    int? offset,
    _i1.OrderByBuilder<ChunkSubtopicMappingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChunkSubtopicMappingTable>? orderByList,
    _i1.Transaction? transaction,
    ChunkSubtopicMappingInclude? include,
  }) async {
    return session.db.findFirstRow<ChunkSubtopicMapping>(
      where: where?.call(ChunkSubtopicMapping.t),
      orderBy: orderBy?.call(ChunkSubtopicMapping.t),
      orderByList: orderByList?.call(ChunkSubtopicMapping.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [ChunkSubtopicMapping] by its [id] or null if no such row exists.
  Future<ChunkSubtopicMapping?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ChunkSubtopicMappingInclude? include,
  }) async {
    return session.db.findById<ChunkSubtopicMapping>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [ChunkSubtopicMapping]s in the list and returns the inserted rows.
  ///
  /// The returned [ChunkSubtopicMapping]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ChunkSubtopicMapping>> insert(
    _i1.Session session,
    List<ChunkSubtopicMapping> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ChunkSubtopicMapping>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ChunkSubtopicMapping] and returns the inserted row.
  ///
  /// The returned [ChunkSubtopicMapping] will have its `id` field set.
  Future<ChunkSubtopicMapping> insertRow(
    _i1.Session session,
    ChunkSubtopicMapping row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ChunkSubtopicMapping>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ChunkSubtopicMapping]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ChunkSubtopicMapping>> update(
    _i1.Session session,
    List<ChunkSubtopicMapping> rows, {
    _i1.ColumnSelections<ChunkSubtopicMappingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ChunkSubtopicMapping>(
      rows,
      columns: columns?.call(ChunkSubtopicMapping.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChunkSubtopicMapping]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ChunkSubtopicMapping> updateRow(
    _i1.Session session,
    ChunkSubtopicMapping row, {
    _i1.ColumnSelections<ChunkSubtopicMappingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ChunkSubtopicMapping>(
      row,
      columns: columns?.call(ChunkSubtopicMapping.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChunkSubtopicMapping] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ChunkSubtopicMapping?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ChunkSubtopicMappingUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ChunkSubtopicMapping>(
      id,
      columnValues: columnValues(ChunkSubtopicMapping.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ChunkSubtopicMapping]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ChunkSubtopicMapping>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ChunkSubtopicMappingUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ChunkSubtopicMappingTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChunkSubtopicMappingTable>? orderBy,
    _i1.OrderByListBuilder<ChunkSubtopicMappingTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ChunkSubtopicMapping>(
      columnValues: columnValues(ChunkSubtopicMapping.t.updateTable),
      where: where(ChunkSubtopicMapping.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChunkSubtopicMapping.t),
      orderByList: orderByList?.call(ChunkSubtopicMapping.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ChunkSubtopicMapping]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ChunkSubtopicMapping>> delete(
    _i1.Session session,
    List<ChunkSubtopicMapping> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ChunkSubtopicMapping>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ChunkSubtopicMapping].
  Future<ChunkSubtopicMapping> deleteRow(
    _i1.Session session,
    ChunkSubtopicMapping row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ChunkSubtopicMapping>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ChunkSubtopicMapping>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ChunkSubtopicMappingTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ChunkSubtopicMapping>(
      where: where(ChunkSubtopicMapping.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChunkSubtopicMappingTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ChunkSubtopicMapping>(
      where: where?.call(ChunkSubtopicMapping.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ChunkSubtopicMappingAttachRowRepository {
  const ChunkSubtopicMappingAttachRowRepository._();

  /// Creates a relation between the given [ChunkSubtopicMapping] and [SemanticChunk]
  /// by setting the [ChunkSubtopicMapping]'s foreign key `chunkId` to refer to the [SemanticChunk].
  Future<void> chunk(
    _i1.Session session,
    ChunkSubtopicMapping chunkSubtopicMapping,
    _i2.SemanticChunk chunk, {
    _i1.Transaction? transaction,
  }) async {
    if (chunkSubtopicMapping.id == null) {
      throw ArgumentError.notNull('chunkSubtopicMapping.id');
    }
    if (chunk.id == null) {
      throw ArgumentError.notNull('chunk.id');
    }

    var $chunkSubtopicMapping = chunkSubtopicMapping.copyWith(
      chunkId: chunk.id,
    );
    await session.db.updateRow<ChunkSubtopicMapping>(
      $chunkSubtopicMapping,
      columns: [ChunkSubtopicMapping.t.chunkId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ChunkSubtopicMapping] and [Subtopic]
  /// by setting the [ChunkSubtopicMapping]'s foreign key `subtopicId` to refer to the [Subtopic].
  Future<void> subtopic(
    _i1.Session session,
    ChunkSubtopicMapping chunkSubtopicMapping,
    _i3.Subtopic subtopic, {
    _i1.Transaction? transaction,
  }) async {
    if (chunkSubtopicMapping.id == null) {
      throw ArgumentError.notNull('chunkSubtopicMapping.id');
    }
    if (subtopic.id == null) {
      throw ArgumentError.notNull('subtopic.id');
    }

    var $chunkSubtopicMapping = chunkSubtopicMapping.copyWith(
      subtopicId: subtopic.id,
    );
    await session.db.updateRow<ChunkSubtopicMapping>(
      $chunkSubtopicMapping,
      columns: [ChunkSubtopicMapping.t.subtopicId],
      transaction: transaction,
    );
  }
}
