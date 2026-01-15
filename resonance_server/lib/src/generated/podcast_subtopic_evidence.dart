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
import 'podcast.dart' as _i2;
import 'subtopic.dart' as _i3;
import 'package:resonance_server/src/generated/protocol.dart' as _i4;

abstract class PodcastSubtopicEvidence
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PodcastSubtopicEvidence._({
    this.id,
    required this.podcastId,
    this.podcast,
    required this.subtopicId,
    this.subtopic,
    int? frequency,
    DateTime? createdAt,
  }) : frequency = frequency ?? 1,
       createdAt = createdAt ?? DateTime.now();

  factory PodcastSubtopicEvidence({
    int? id,
    required int podcastId,
    _i2.Podcast? podcast,
    required int subtopicId,
    _i3.Subtopic? subtopic,
    int? frequency,
    DateTime? createdAt,
  }) = _PodcastSubtopicEvidenceImpl;

  factory PodcastSubtopicEvidence.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return PodcastSubtopicEvidence(
      id: jsonSerialization['id'] as int?,
      podcastId: jsonSerialization['podcastId'] as int,
      podcast: jsonSerialization['podcast'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Podcast>(
              jsonSerialization['podcast'],
            ),
      subtopicId: jsonSerialization['subtopicId'] as int,
      subtopic: jsonSerialization['subtopic'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Subtopic>(
              jsonSerialization['subtopic'],
            ),
      frequency: jsonSerialization['frequency'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = PodcastSubtopicEvidenceTable();

  static const db = PodcastSubtopicEvidenceRepository._();

  @override
  int? id;

  int podcastId;

  /// The podcast
  _i2.Podcast? podcast;

  int subtopicId;

  /// The subtopic
  _i3.Subtopic? subtopic;

  /// Frequency count (how many times this subtopic appears in the podcast)
  int frequency;

  /// When this evidence was created
  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PodcastSubtopicEvidence]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PodcastSubtopicEvidence copyWith({
    int? id,
    int? podcastId,
    _i2.Podcast? podcast,
    int? subtopicId,
    _i3.Subtopic? subtopic,
    int? frequency,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PodcastSubtopicEvidence',
      if (id != null) 'id': id,
      'podcastId': podcastId,
      if (podcast != null) 'podcast': podcast?.toJson(),
      'subtopicId': subtopicId,
      if (subtopic != null) 'subtopic': subtopic?.toJson(),
      'frequency': frequency,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PodcastSubtopicEvidence',
      if (id != null) 'id': id,
      'podcastId': podcastId,
      if (podcast != null) 'podcast': podcast?.toJsonForProtocol(),
      'subtopicId': subtopicId,
      if (subtopic != null) 'subtopic': subtopic?.toJsonForProtocol(),
      'frequency': frequency,
      'createdAt': createdAt.toJson(),
    };
  }

  static PodcastSubtopicEvidenceInclude include({
    _i2.PodcastInclude? podcast,
    _i3.SubtopicInclude? subtopic,
  }) {
    return PodcastSubtopicEvidenceInclude._(
      podcast: podcast,
      subtopic: subtopic,
    );
  }

  static PodcastSubtopicEvidenceIncludeList includeList({
    _i1.WhereExpressionBuilder<PodcastSubtopicEvidenceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PodcastSubtopicEvidenceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PodcastSubtopicEvidenceTable>? orderByList,
    PodcastSubtopicEvidenceInclude? include,
  }) {
    return PodcastSubtopicEvidenceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PodcastSubtopicEvidence.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PodcastSubtopicEvidence.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PodcastSubtopicEvidenceImpl extends PodcastSubtopicEvidence {
  _PodcastSubtopicEvidenceImpl({
    int? id,
    required int podcastId,
    _i2.Podcast? podcast,
    required int subtopicId,
    _i3.Subtopic? subtopic,
    int? frequency,
    DateTime? createdAt,
  }) : super._(
         id: id,
         podcastId: podcastId,
         podcast: podcast,
         subtopicId: subtopicId,
         subtopic: subtopic,
         frequency: frequency,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PodcastSubtopicEvidence]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PodcastSubtopicEvidence copyWith({
    Object? id = _Undefined,
    int? podcastId,
    Object? podcast = _Undefined,
    int? subtopicId,
    Object? subtopic = _Undefined,
    int? frequency,
    DateTime? createdAt,
  }) {
    return PodcastSubtopicEvidence(
      id: id is int? ? id : this.id,
      podcastId: podcastId ?? this.podcastId,
      podcast: podcast is _i2.Podcast? ? podcast : this.podcast?.copyWith(),
      subtopicId: subtopicId ?? this.subtopicId,
      subtopic: subtopic is _i3.Subtopic?
          ? subtopic
          : this.subtopic?.copyWith(),
      frequency: frequency ?? this.frequency,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class PodcastSubtopicEvidenceUpdateTable
    extends _i1.UpdateTable<PodcastSubtopicEvidenceTable> {
  PodcastSubtopicEvidenceUpdateTable(super.table);

  _i1.ColumnValue<int, int> podcastId(int value) => _i1.ColumnValue(
    table.podcastId,
    value,
  );

  _i1.ColumnValue<int, int> subtopicId(int value) => _i1.ColumnValue(
    table.subtopicId,
    value,
  );

  _i1.ColumnValue<int, int> frequency(int value) => _i1.ColumnValue(
    table.frequency,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class PodcastSubtopicEvidenceTable extends _i1.Table<int?> {
  PodcastSubtopicEvidenceTable({super.tableRelation})
    : super(tableName: 'podcast_subtopic_evidence') {
    updateTable = PodcastSubtopicEvidenceUpdateTable(this);
    podcastId = _i1.ColumnInt(
      'podcastId',
      this,
    );
    subtopicId = _i1.ColumnInt(
      'subtopicId',
      this,
    );
    frequency = _i1.ColumnInt(
      'frequency',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final PodcastSubtopicEvidenceUpdateTable updateTable;

  late final _i1.ColumnInt podcastId;

  /// The podcast
  _i2.PodcastTable? _podcast;

  late final _i1.ColumnInt subtopicId;

  /// The subtopic
  _i3.SubtopicTable? _subtopic;

  /// Frequency count (how many times this subtopic appears in the podcast)
  late final _i1.ColumnInt frequency;

  /// When this evidence was created
  late final _i1.ColumnDateTime createdAt;

  _i2.PodcastTable get podcast {
    if (_podcast != null) return _podcast!;
    _podcast = _i1.createRelationTable(
      relationFieldName: 'podcast',
      field: PodcastSubtopicEvidence.t.podcastId,
      foreignField: _i2.Podcast.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PodcastTable(tableRelation: foreignTableRelation),
    );
    return _podcast!;
  }

  _i3.SubtopicTable get subtopic {
    if (_subtopic != null) return _subtopic!;
    _subtopic = _i1.createRelationTable(
      relationFieldName: 'subtopic',
      field: PodcastSubtopicEvidence.t.subtopicId,
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
    podcastId,
    subtopicId,
    frequency,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'podcast') {
      return podcast;
    }
    if (relationField == 'subtopic') {
      return subtopic;
    }
    return null;
  }
}

class PodcastSubtopicEvidenceInclude extends _i1.IncludeObject {
  PodcastSubtopicEvidenceInclude._({
    _i2.PodcastInclude? podcast,
    _i3.SubtopicInclude? subtopic,
  }) {
    _podcast = podcast;
    _subtopic = subtopic;
  }

  _i2.PodcastInclude? _podcast;

  _i3.SubtopicInclude? _subtopic;

  @override
  Map<String, _i1.Include?> get includes => {
    'podcast': _podcast,
    'subtopic': _subtopic,
  };

  @override
  _i1.Table<int?> get table => PodcastSubtopicEvidence.t;
}

class PodcastSubtopicEvidenceIncludeList extends _i1.IncludeList {
  PodcastSubtopicEvidenceIncludeList._({
    _i1.WhereExpressionBuilder<PodcastSubtopicEvidenceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PodcastSubtopicEvidence.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PodcastSubtopicEvidence.t;
}

class PodcastSubtopicEvidenceRepository {
  const PodcastSubtopicEvidenceRepository._();

  final attachRow = const PodcastSubtopicEvidenceAttachRowRepository._();

  /// Returns a list of [PodcastSubtopicEvidence]s matching the given query parameters.
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
  Future<List<PodcastSubtopicEvidence>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PodcastSubtopicEvidenceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PodcastSubtopicEvidenceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PodcastSubtopicEvidenceTable>? orderByList,
    _i1.Transaction? transaction,
    PodcastSubtopicEvidenceInclude? include,
  }) async {
    return session.db.find<PodcastSubtopicEvidence>(
      where: where?.call(PodcastSubtopicEvidence.t),
      orderBy: orderBy?.call(PodcastSubtopicEvidence.t),
      orderByList: orderByList?.call(PodcastSubtopicEvidence.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [PodcastSubtopicEvidence] matching the given query parameters.
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
  Future<PodcastSubtopicEvidence?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PodcastSubtopicEvidenceTable>? where,
    int? offset,
    _i1.OrderByBuilder<PodcastSubtopicEvidenceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PodcastSubtopicEvidenceTable>? orderByList,
    _i1.Transaction? transaction,
    PodcastSubtopicEvidenceInclude? include,
  }) async {
    return session.db.findFirstRow<PodcastSubtopicEvidence>(
      where: where?.call(PodcastSubtopicEvidence.t),
      orderBy: orderBy?.call(PodcastSubtopicEvidence.t),
      orderByList: orderByList?.call(PodcastSubtopicEvidence.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [PodcastSubtopicEvidence] by its [id] or null if no such row exists.
  Future<PodcastSubtopicEvidence?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    PodcastSubtopicEvidenceInclude? include,
  }) async {
    return session.db.findById<PodcastSubtopicEvidence>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [PodcastSubtopicEvidence]s in the list and returns the inserted rows.
  ///
  /// The returned [PodcastSubtopicEvidence]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PodcastSubtopicEvidence>> insert(
    _i1.Session session,
    List<PodcastSubtopicEvidence> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PodcastSubtopicEvidence>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PodcastSubtopicEvidence] and returns the inserted row.
  ///
  /// The returned [PodcastSubtopicEvidence] will have its `id` field set.
  Future<PodcastSubtopicEvidence> insertRow(
    _i1.Session session,
    PodcastSubtopicEvidence row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PodcastSubtopicEvidence>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PodcastSubtopicEvidence]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PodcastSubtopicEvidence>> update(
    _i1.Session session,
    List<PodcastSubtopicEvidence> rows, {
    _i1.ColumnSelections<PodcastSubtopicEvidenceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PodcastSubtopicEvidence>(
      rows,
      columns: columns?.call(PodcastSubtopicEvidence.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PodcastSubtopicEvidence]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PodcastSubtopicEvidence> updateRow(
    _i1.Session session,
    PodcastSubtopicEvidence row, {
    _i1.ColumnSelections<PodcastSubtopicEvidenceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PodcastSubtopicEvidence>(
      row,
      columns: columns?.call(PodcastSubtopicEvidence.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PodcastSubtopicEvidence] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PodcastSubtopicEvidence?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<PodcastSubtopicEvidenceUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PodcastSubtopicEvidence>(
      id,
      columnValues: columnValues(PodcastSubtopicEvidence.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PodcastSubtopicEvidence]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PodcastSubtopicEvidence>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<PodcastSubtopicEvidenceUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<PodcastSubtopicEvidenceTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PodcastSubtopicEvidenceTable>? orderBy,
    _i1.OrderByListBuilder<PodcastSubtopicEvidenceTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PodcastSubtopicEvidence>(
      columnValues: columnValues(PodcastSubtopicEvidence.t.updateTable),
      where: where(PodcastSubtopicEvidence.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PodcastSubtopicEvidence.t),
      orderByList: orderByList?.call(PodcastSubtopicEvidence.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PodcastSubtopicEvidence]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PodcastSubtopicEvidence>> delete(
    _i1.Session session,
    List<PodcastSubtopicEvidence> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PodcastSubtopicEvidence>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PodcastSubtopicEvidence].
  Future<PodcastSubtopicEvidence> deleteRow(
    _i1.Session session,
    PodcastSubtopicEvidence row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PodcastSubtopicEvidence>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PodcastSubtopicEvidence>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PodcastSubtopicEvidenceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PodcastSubtopicEvidence>(
      where: where(PodcastSubtopicEvidence.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PodcastSubtopicEvidenceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PodcastSubtopicEvidence>(
      where: where?.call(PodcastSubtopicEvidence.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class PodcastSubtopicEvidenceAttachRowRepository {
  const PodcastSubtopicEvidenceAttachRowRepository._();

  /// Creates a relation between the given [PodcastSubtopicEvidence] and [Podcast]
  /// by setting the [PodcastSubtopicEvidence]'s foreign key `podcastId` to refer to the [Podcast].
  Future<void> podcast(
    _i1.Session session,
    PodcastSubtopicEvidence podcastSubtopicEvidence,
    _i2.Podcast podcast, {
    _i1.Transaction? transaction,
  }) async {
    if (podcastSubtopicEvidence.id == null) {
      throw ArgumentError.notNull('podcastSubtopicEvidence.id');
    }
    if (podcast.id == null) {
      throw ArgumentError.notNull('podcast.id');
    }

    var $podcastSubtopicEvidence = podcastSubtopicEvidence.copyWith(
      podcastId: podcast.id,
    );
    await session.db.updateRow<PodcastSubtopicEvidence>(
      $podcastSubtopicEvidence,
      columns: [PodcastSubtopicEvidence.t.podcastId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [PodcastSubtopicEvidence] and [Subtopic]
  /// by setting the [PodcastSubtopicEvidence]'s foreign key `subtopicId` to refer to the [Subtopic].
  Future<void> subtopic(
    _i1.Session session,
    PodcastSubtopicEvidence podcastSubtopicEvidence,
    _i3.Subtopic subtopic, {
    _i1.Transaction? transaction,
  }) async {
    if (podcastSubtopicEvidence.id == null) {
      throw ArgumentError.notNull('podcastSubtopicEvidence.id');
    }
    if (subtopic.id == null) {
      throw ArgumentError.notNull('subtopic.id');
    }

    var $podcastSubtopicEvidence = podcastSubtopicEvidence.copyWith(
      subtopicId: subtopic.id,
    );
    await session.db.updateRow<PodcastSubtopicEvidence>(
      $podcastSubtopicEvidence,
      columns: [PodcastSubtopicEvidence.t.subtopicId],
      transaction: transaction,
    );
  }
}
