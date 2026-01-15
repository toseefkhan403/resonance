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
import 'transcript_segment.dart' as _i3;
import 'package:resonance_server/src/generated/protocol.dart' as _i4;

abstract class Transcript
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Transcript._({
    this.id,
    required this.podcastId,
    this.podcast,
    required this.videoId,
    required this.segments,
    required this.isGenerated,
    required this.language,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Transcript({
    int? id,
    required int podcastId,
    _i2.Podcast? podcast,
    required String videoId,
    required List<_i3.TranscriptSegment> segments,
    required bool isGenerated,
    required String language,
    DateTime? createdAt,
  }) = _TranscriptImpl;

  factory Transcript.fromJson(Map<String, dynamic> jsonSerialization) {
    return Transcript(
      id: jsonSerialization['id'] as int?,
      podcastId: jsonSerialization['podcastId'] as int,
      podcast: jsonSerialization['podcast'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Podcast>(
              jsonSerialization['podcast'],
            ),
      videoId: jsonSerialization['videoId'] as String,
      segments: _i4.Protocol().deserialize<List<_i3.TranscriptSegment>>(
        jsonSerialization['segments'],
      ),
      isGenerated: jsonSerialization['isGenerated'] as bool,
      language: jsonSerialization['language'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = TranscriptTable();

  static const db = TranscriptRepository._();

  @override
  int? id;

  int podcastId;

  /// The podcast this transcript belongs to
  _i2.Podcast? podcast;

  /// The video ID this transcript belongs to
  String videoId;

  /// Transcript segments with timestamps
  List<_i3.TranscriptSegment> segments;

  /// Source: captions, stt
  bool isGenerated;

  /// Language
  String language;

  /// When the transcript was created
  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Transcript]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Transcript copyWith({
    int? id,
    int? podcastId,
    _i2.Podcast? podcast,
    String? videoId,
    List<_i3.TranscriptSegment>? segments,
    bool? isGenerated,
    String? language,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Transcript',
      if (id != null) 'id': id,
      'podcastId': podcastId,
      if (podcast != null) 'podcast': podcast?.toJson(),
      'videoId': videoId,
      'segments': segments.toJson(valueToJson: (v) => v.toJson()),
      'isGenerated': isGenerated,
      'language': language,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Transcript',
      if (id != null) 'id': id,
      'podcastId': podcastId,
      if (podcast != null) 'podcast': podcast?.toJsonForProtocol(),
      'videoId': videoId,
      'segments': segments.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'isGenerated': isGenerated,
      'language': language,
      'createdAt': createdAt.toJson(),
    };
  }

  static TranscriptInclude include({_i2.PodcastInclude? podcast}) {
    return TranscriptInclude._(podcast: podcast);
  }

  static TranscriptIncludeList includeList({
    _i1.WhereExpressionBuilder<TranscriptTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TranscriptTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TranscriptTable>? orderByList,
    TranscriptInclude? include,
  }) {
    return TranscriptIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Transcript.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Transcript.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TranscriptImpl extends Transcript {
  _TranscriptImpl({
    int? id,
    required int podcastId,
    _i2.Podcast? podcast,
    required String videoId,
    required List<_i3.TranscriptSegment> segments,
    required bool isGenerated,
    required String language,
    DateTime? createdAt,
  }) : super._(
         id: id,
         podcastId: podcastId,
         podcast: podcast,
         videoId: videoId,
         segments: segments,
         isGenerated: isGenerated,
         language: language,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Transcript]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Transcript copyWith({
    Object? id = _Undefined,
    int? podcastId,
    Object? podcast = _Undefined,
    String? videoId,
    List<_i3.TranscriptSegment>? segments,
    bool? isGenerated,
    String? language,
    DateTime? createdAt,
  }) {
    return Transcript(
      id: id is int? ? id : this.id,
      podcastId: podcastId ?? this.podcastId,
      podcast: podcast is _i2.Podcast? ? podcast : this.podcast?.copyWith(),
      videoId: videoId ?? this.videoId,
      segments: segments ?? this.segments.map((e0) => e0.copyWith()).toList(),
      isGenerated: isGenerated ?? this.isGenerated,
      language: language ?? this.language,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class TranscriptUpdateTable extends _i1.UpdateTable<TranscriptTable> {
  TranscriptUpdateTable(super.table);

  _i1.ColumnValue<int, int> podcastId(int value) => _i1.ColumnValue(
    table.podcastId,
    value,
  );

  _i1.ColumnValue<String, String> videoId(String value) => _i1.ColumnValue(
    table.videoId,
    value,
  );

  _i1.ColumnValue<List<_i3.TranscriptSegment>, List<_i3.TranscriptSegment>>
  segments(List<_i3.TranscriptSegment> value) => _i1.ColumnValue(
    table.segments,
    value,
  );

  _i1.ColumnValue<bool, bool> isGenerated(bool value) => _i1.ColumnValue(
    table.isGenerated,
    value,
  );

  _i1.ColumnValue<String, String> language(String value) => _i1.ColumnValue(
    table.language,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class TranscriptTable extends _i1.Table<int?> {
  TranscriptTable({super.tableRelation}) : super(tableName: 'transcript') {
    updateTable = TranscriptUpdateTable(this);
    podcastId = _i1.ColumnInt(
      'podcastId',
      this,
    );
    videoId = _i1.ColumnString(
      'videoId',
      this,
    );
    segments = _i1.ColumnSerializable<List<_i3.TranscriptSegment>>(
      'segments',
      this,
    );
    isGenerated = _i1.ColumnBool(
      'isGenerated',
      this,
    );
    language = _i1.ColumnString(
      'language',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final TranscriptUpdateTable updateTable;

  late final _i1.ColumnInt podcastId;

  /// The podcast this transcript belongs to
  _i2.PodcastTable? _podcast;

  /// The video ID this transcript belongs to
  late final _i1.ColumnString videoId;

  /// Transcript segments with timestamps
  late final _i1.ColumnSerializable<List<_i3.TranscriptSegment>> segments;

  /// Source: captions, stt
  late final _i1.ColumnBool isGenerated;

  /// Language
  late final _i1.ColumnString language;

  /// When the transcript was created
  late final _i1.ColumnDateTime createdAt;

  _i2.PodcastTable get podcast {
    if (_podcast != null) return _podcast!;
    _podcast = _i1.createRelationTable(
      relationFieldName: 'podcast',
      field: Transcript.t.podcastId,
      foreignField: _i2.Podcast.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PodcastTable(tableRelation: foreignTableRelation),
    );
    return _podcast!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    podcastId,
    videoId,
    segments,
    isGenerated,
    language,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'podcast') {
      return podcast;
    }
    return null;
  }
}

class TranscriptInclude extends _i1.IncludeObject {
  TranscriptInclude._({_i2.PodcastInclude? podcast}) {
    _podcast = podcast;
  }

  _i2.PodcastInclude? _podcast;

  @override
  Map<String, _i1.Include?> get includes => {'podcast': _podcast};

  @override
  _i1.Table<int?> get table => Transcript.t;
}

class TranscriptIncludeList extends _i1.IncludeList {
  TranscriptIncludeList._({
    _i1.WhereExpressionBuilder<TranscriptTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Transcript.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Transcript.t;
}

class TranscriptRepository {
  const TranscriptRepository._();

  final attachRow = const TranscriptAttachRowRepository._();

  /// Returns a list of [Transcript]s matching the given query parameters.
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
  Future<List<Transcript>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TranscriptTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TranscriptTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TranscriptTable>? orderByList,
    _i1.Transaction? transaction,
    TranscriptInclude? include,
  }) async {
    return session.db.find<Transcript>(
      where: where?.call(Transcript.t),
      orderBy: orderBy?.call(Transcript.t),
      orderByList: orderByList?.call(Transcript.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Transcript] matching the given query parameters.
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
  Future<Transcript?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TranscriptTable>? where,
    int? offset,
    _i1.OrderByBuilder<TranscriptTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TranscriptTable>? orderByList,
    _i1.Transaction? transaction,
    TranscriptInclude? include,
  }) async {
    return session.db.findFirstRow<Transcript>(
      where: where?.call(Transcript.t),
      orderBy: orderBy?.call(Transcript.t),
      orderByList: orderByList?.call(Transcript.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Transcript] by its [id] or null if no such row exists.
  Future<Transcript?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    TranscriptInclude? include,
  }) async {
    return session.db.findById<Transcript>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Transcript]s in the list and returns the inserted rows.
  ///
  /// The returned [Transcript]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Transcript>> insert(
    _i1.Session session,
    List<Transcript> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Transcript>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Transcript] and returns the inserted row.
  ///
  /// The returned [Transcript] will have its `id` field set.
  Future<Transcript> insertRow(
    _i1.Session session,
    Transcript row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Transcript>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Transcript]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Transcript>> update(
    _i1.Session session,
    List<Transcript> rows, {
    _i1.ColumnSelections<TranscriptTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Transcript>(
      rows,
      columns: columns?.call(Transcript.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Transcript]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Transcript> updateRow(
    _i1.Session session,
    Transcript row, {
    _i1.ColumnSelections<TranscriptTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Transcript>(
      row,
      columns: columns?.call(Transcript.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Transcript] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Transcript?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<TranscriptUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Transcript>(
      id,
      columnValues: columnValues(Transcript.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Transcript]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Transcript>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<TranscriptUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<TranscriptTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TranscriptTable>? orderBy,
    _i1.OrderByListBuilder<TranscriptTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Transcript>(
      columnValues: columnValues(Transcript.t.updateTable),
      where: where(Transcript.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Transcript.t),
      orderByList: orderByList?.call(Transcript.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Transcript]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Transcript>> delete(
    _i1.Session session,
    List<Transcript> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Transcript>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Transcript].
  Future<Transcript> deleteRow(
    _i1.Session session,
    Transcript row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Transcript>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Transcript>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TranscriptTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Transcript>(
      where: where(Transcript.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TranscriptTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Transcript>(
      where: where?.call(Transcript.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class TranscriptAttachRowRepository {
  const TranscriptAttachRowRepository._();

  /// Creates a relation between the given [Transcript] and [Podcast]
  /// by setting the [Transcript]'s foreign key `podcastId` to refer to the [Podcast].
  Future<void> podcast(
    _i1.Session session,
    Transcript transcript,
    _i2.Podcast podcast, {
    _i1.Transaction? transaction,
  }) async {
    if (transcript.id == null) {
      throw ArgumentError.notNull('transcript.id');
    }
    if (podcast.id == null) {
      throw ArgumentError.notNull('podcast.id');
    }

    var $transcript = transcript.copyWith(podcastId: podcast.id);
    await session.db.updateRow<Transcript>(
      $transcript,
      columns: [Transcript.t.podcastId],
      transaction: transaction,
    );
  }
}
