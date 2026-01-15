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
import 'transcript.dart' as _i2;
import 'podcast.dart' as _i3;
import 'package:resonance_server/src/generated/protocol.dart' as _i4;

abstract class SemanticChunk
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SemanticChunk._({
    this.id,
    required this.transcriptId,
    this.transcript,
    required this.podcastId,
    this.podcast,
    required this.startTime,
    required this.endTime,
    required this.text,
    required this.embedding,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory SemanticChunk({
    int? id,
    required int transcriptId,
    _i2.Transcript? transcript,
    required int podcastId,
    _i3.Podcast? podcast,
    required double startTime,
    required double endTime,
    required String text,
    required _i1.Vector embedding,
    DateTime? createdAt,
  }) = _SemanticChunkImpl;

  factory SemanticChunk.fromJson(Map<String, dynamic> jsonSerialization) {
    return SemanticChunk(
      id: jsonSerialization['id'] as int?,
      transcriptId: jsonSerialization['transcriptId'] as int,
      transcript: jsonSerialization['transcript'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Transcript>(
              jsonSerialization['transcript'],
            ),
      podcastId: jsonSerialization['podcastId'] as int,
      podcast: jsonSerialization['podcast'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Podcast>(
              jsonSerialization['podcast'],
            ),
      startTime: (jsonSerialization['startTime'] as num).toDouble(),
      endTime: (jsonSerialization['endTime'] as num).toDouble(),
      text: jsonSerialization['text'] as String,
      embedding: _i1.VectorJsonExtension.fromJson(
        jsonSerialization['embedding'],
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = SemanticChunkTable();

  static const db = SemanticChunkRepository._();

  @override
  int? id;

  int transcriptId;

  /// The transcript this chunk came from
  _i2.Transcript? transcript;

  int podcastId;

  /// The podcast this chunk belongs to
  _i3.Podcast? podcast;

  /// Start timestamp in seconds
  double startTime;

  /// End timestamp in seconds
  double endTime;

  /// The text content of this chunk
  String text;

  /// The embedding vector (768 dimensions)
  _i1.Vector embedding;

  /// When this chunk was created
  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SemanticChunk]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SemanticChunk copyWith({
    int? id,
    int? transcriptId,
    _i2.Transcript? transcript,
    int? podcastId,
    _i3.Podcast? podcast,
    double? startTime,
    double? endTime,
    String? text,
    _i1.Vector? embedding,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SemanticChunk',
      if (id != null) 'id': id,
      'transcriptId': transcriptId,
      if (transcript != null) 'transcript': transcript?.toJson(),
      'podcastId': podcastId,
      if (podcast != null) 'podcast': podcast?.toJson(),
      'startTime': startTime,
      'endTime': endTime,
      'text': text,
      'embedding': embedding.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SemanticChunk',
      if (id != null) 'id': id,
      'transcriptId': transcriptId,
      if (transcript != null) 'transcript': transcript?.toJsonForProtocol(),
      'podcastId': podcastId,
      if (podcast != null) 'podcast': podcast?.toJsonForProtocol(),
      'startTime': startTime,
      'endTime': endTime,
      'text': text,
      'embedding': embedding.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static SemanticChunkInclude include({
    _i2.TranscriptInclude? transcript,
    _i3.PodcastInclude? podcast,
  }) {
    return SemanticChunkInclude._(
      transcript: transcript,
      podcast: podcast,
    );
  }

  static SemanticChunkIncludeList includeList({
    _i1.WhereExpressionBuilder<SemanticChunkTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SemanticChunkTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SemanticChunkTable>? orderByList,
    SemanticChunkInclude? include,
  }) {
    return SemanticChunkIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SemanticChunk.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SemanticChunk.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SemanticChunkImpl extends SemanticChunk {
  _SemanticChunkImpl({
    int? id,
    required int transcriptId,
    _i2.Transcript? transcript,
    required int podcastId,
    _i3.Podcast? podcast,
    required double startTime,
    required double endTime,
    required String text,
    required _i1.Vector embedding,
    DateTime? createdAt,
  }) : super._(
         id: id,
         transcriptId: transcriptId,
         transcript: transcript,
         podcastId: podcastId,
         podcast: podcast,
         startTime: startTime,
         endTime: endTime,
         text: text,
         embedding: embedding,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [SemanticChunk]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SemanticChunk copyWith({
    Object? id = _Undefined,
    int? transcriptId,
    Object? transcript = _Undefined,
    int? podcastId,
    Object? podcast = _Undefined,
    double? startTime,
    double? endTime,
    String? text,
    _i1.Vector? embedding,
    DateTime? createdAt,
  }) {
    return SemanticChunk(
      id: id is int? ? id : this.id,
      transcriptId: transcriptId ?? this.transcriptId,
      transcript: transcript is _i2.Transcript?
          ? transcript
          : this.transcript?.copyWith(),
      podcastId: podcastId ?? this.podcastId,
      podcast: podcast is _i3.Podcast? ? podcast : this.podcast?.copyWith(),
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      text: text ?? this.text,
      embedding: embedding ?? this.embedding.clone(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class SemanticChunkUpdateTable extends _i1.UpdateTable<SemanticChunkTable> {
  SemanticChunkUpdateTable(super.table);

  _i1.ColumnValue<int, int> transcriptId(int value) => _i1.ColumnValue(
    table.transcriptId,
    value,
  );

  _i1.ColumnValue<int, int> podcastId(int value) => _i1.ColumnValue(
    table.podcastId,
    value,
  );

  _i1.ColumnValue<double, double> startTime(double value) => _i1.ColumnValue(
    table.startTime,
    value,
  );

  _i1.ColumnValue<double, double> endTime(double value) => _i1.ColumnValue(
    table.endTime,
    value,
  );

  _i1.ColumnValue<String, String> text(String value) => _i1.ColumnValue(
    table.text,
    value,
  );

  _i1.ColumnValue<_i1.Vector, _i1.Vector> embedding(_i1.Vector value) =>
      _i1.ColumnValue(
        table.embedding,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class SemanticChunkTable extends _i1.Table<int?> {
  SemanticChunkTable({super.tableRelation})
    : super(tableName: 'semantic_chunk') {
    updateTable = SemanticChunkUpdateTable(this);
    transcriptId = _i1.ColumnInt(
      'transcriptId',
      this,
    );
    podcastId = _i1.ColumnInt(
      'podcastId',
      this,
    );
    startTime = _i1.ColumnDouble(
      'startTime',
      this,
    );
    endTime = _i1.ColumnDouble(
      'endTime',
      this,
    );
    text = _i1.ColumnString(
      'text',
      this,
    );
    embedding = _i1.ColumnVector(
      'embedding',
      this,
      dimension: 768,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final SemanticChunkUpdateTable updateTable;

  late final _i1.ColumnInt transcriptId;

  /// The transcript this chunk came from
  _i2.TranscriptTable? _transcript;

  late final _i1.ColumnInt podcastId;

  /// The podcast this chunk belongs to
  _i3.PodcastTable? _podcast;

  /// Start timestamp in seconds
  late final _i1.ColumnDouble startTime;

  /// End timestamp in seconds
  late final _i1.ColumnDouble endTime;

  /// The text content of this chunk
  late final _i1.ColumnString text;

  /// The embedding vector (768 dimensions)
  late final _i1.ColumnVector embedding;

  /// When this chunk was created
  late final _i1.ColumnDateTime createdAt;

  _i2.TranscriptTable get transcript {
    if (_transcript != null) return _transcript!;
    _transcript = _i1.createRelationTable(
      relationFieldName: 'transcript',
      field: SemanticChunk.t.transcriptId,
      foreignField: _i2.Transcript.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.TranscriptTable(tableRelation: foreignTableRelation),
    );
    return _transcript!;
  }

  _i3.PodcastTable get podcast {
    if (_podcast != null) return _podcast!;
    _podcast = _i1.createRelationTable(
      relationFieldName: 'podcast',
      field: SemanticChunk.t.podcastId,
      foreignField: _i3.Podcast.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PodcastTable(tableRelation: foreignTableRelation),
    );
    return _podcast!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    transcriptId,
    podcastId,
    startTime,
    endTime,
    text,
    embedding,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'transcript') {
      return transcript;
    }
    if (relationField == 'podcast') {
      return podcast;
    }
    return null;
  }
}

class SemanticChunkInclude extends _i1.IncludeObject {
  SemanticChunkInclude._({
    _i2.TranscriptInclude? transcript,
    _i3.PodcastInclude? podcast,
  }) {
    _transcript = transcript;
    _podcast = podcast;
  }

  _i2.TranscriptInclude? _transcript;

  _i3.PodcastInclude? _podcast;

  @override
  Map<String, _i1.Include?> get includes => {
    'transcript': _transcript,
    'podcast': _podcast,
  };

  @override
  _i1.Table<int?> get table => SemanticChunk.t;
}

class SemanticChunkIncludeList extends _i1.IncludeList {
  SemanticChunkIncludeList._({
    _i1.WhereExpressionBuilder<SemanticChunkTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SemanticChunk.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SemanticChunk.t;
}

class SemanticChunkRepository {
  const SemanticChunkRepository._();

  final attachRow = const SemanticChunkAttachRowRepository._();

  /// Returns a list of [SemanticChunk]s matching the given query parameters.
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
  Future<List<SemanticChunk>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SemanticChunkTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SemanticChunkTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SemanticChunkTable>? orderByList,
    _i1.Transaction? transaction,
    SemanticChunkInclude? include,
  }) async {
    return session.db.find<SemanticChunk>(
      where: where?.call(SemanticChunk.t),
      orderBy: orderBy?.call(SemanticChunk.t),
      orderByList: orderByList?.call(SemanticChunk.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [SemanticChunk] matching the given query parameters.
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
  Future<SemanticChunk?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SemanticChunkTable>? where,
    int? offset,
    _i1.OrderByBuilder<SemanticChunkTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SemanticChunkTable>? orderByList,
    _i1.Transaction? transaction,
    SemanticChunkInclude? include,
  }) async {
    return session.db.findFirstRow<SemanticChunk>(
      where: where?.call(SemanticChunk.t),
      orderBy: orderBy?.call(SemanticChunk.t),
      orderByList: orderByList?.call(SemanticChunk.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [SemanticChunk] by its [id] or null if no such row exists.
  Future<SemanticChunk?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    SemanticChunkInclude? include,
  }) async {
    return session.db.findById<SemanticChunk>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [SemanticChunk]s in the list and returns the inserted rows.
  ///
  /// The returned [SemanticChunk]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SemanticChunk>> insert(
    _i1.Session session,
    List<SemanticChunk> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SemanticChunk>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SemanticChunk] and returns the inserted row.
  ///
  /// The returned [SemanticChunk] will have its `id` field set.
  Future<SemanticChunk> insertRow(
    _i1.Session session,
    SemanticChunk row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SemanticChunk>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SemanticChunk]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SemanticChunk>> update(
    _i1.Session session,
    List<SemanticChunk> rows, {
    _i1.ColumnSelections<SemanticChunkTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SemanticChunk>(
      rows,
      columns: columns?.call(SemanticChunk.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SemanticChunk]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SemanticChunk> updateRow(
    _i1.Session session,
    SemanticChunk row, {
    _i1.ColumnSelections<SemanticChunkTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SemanticChunk>(
      row,
      columns: columns?.call(SemanticChunk.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SemanticChunk] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SemanticChunk?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<SemanticChunkUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SemanticChunk>(
      id,
      columnValues: columnValues(SemanticChunk.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SemanticChunk]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SemanticChunk>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<SemanticChunkUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SemanticChunkTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SemanticChunkTable>? orderBy,
    _i1.OrderByListBuilder<SemanticChunkTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SemanticChunk>(
      columnValues: columnValues(SemanticChunk.t.updateTable),
      where: where(SemanticChunk.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SemanticChunk.t),
      orderByList: orderByList?.call(SemanticChunk.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SemanticChunk]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SemanticChunk>> delete(
    _i1.Session session,
    List<SemanticChunk> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SemanticChunk>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SemanticChunk].
  Future<SemanticChunk> deleteRow(
    _i1.Session session,
    SemanticChunk row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SemanticChunk>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SemanticChunk>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SemanticChunkTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SemanticChunk>(
      where: where(SemanticChunk.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SemanticChunkTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SemanticChunk>(
      where: where?.call(SemanticChunk.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class SemanticChunkAttachRowRepository {
  const SemanticChunkAttachRowRepository._();

  /// Creates a relation between the given [SemanticChunk] and [Transcript]
  /// by setting the [SemanticChunk]'s foreign key `transcriptId` to refer to the [Transcript].
  Future<void> transcript(
    _i1.Session session,
    SemanticChunk semanticChunk,
    _i2.Transcript transcript, {
    _i1.Transaction? transaction,
  }) async {
    if (semanticChunk.id == null) {
      throw ArgumentError.notNull('semanticChunk.id');
    }
    if (transcript.id == null) {
      throw ArgumentError.notNull('transcript.id');
    }

    var $semanticChunk = semanticChunk.copyWith(transcriptId: transcript.id);
    await session.db.updateRow<SemanticChunk>(
      $semanticChunk,
      columns: [SemanticChunk.t.transcriptId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [SemanticChunk] and [Podcast]
  /// by setting the [SemanticChunk]'s foreign key `podcastId` to refer to the [Podcast].
  Future<void> podcast(
    _i1.Session session,
    SemanticChunk semanticChunk,
    _i3.Podcast podcast, {
    _i1.Transaction? transaction,
  }) async {
    if (semanticChunk.id == null) {
      throw ArgumentError.notNull('semanticChunk.id');
    }
    if (podcast.id == null) {
      throw ArgumentError.notNull('podcast.id');
    }

    var $semanticChunk = semanticChunk.copyWith(podcastId: podcast.id);
    await session.db.updateRow<SemanticChunk>(
      $semanticChunk,
      columns: [SemanticChunk.t.podcastId],
      transaction: transaction,
    );
  }
}
