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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import 'category.dart' as _i5;
import 'chunk_subtopic_mapping.dart' as _i6;
import 'conversation_response.dart' as _i7;
import 'graph_data.dart' as _i8;
import 'graph_link.dart' as _i9;
import 'graph_node.dart' as _i10;
import 'graph_relationship.dart' as _i11;
import 'ingestion_job.dart' as _i12;
import 'podcast.dart' as _i13;
import 'podcast_reference.dart' as _i14;
import 'podcast_subtopic_evidence.dart' as _i15;
import 'semantic_chunk.dart' as _i16;
import 'subtopic.dart' as _i17;
import 'subtopic_detail.dart' as _i18;
import 'timestamp_reference.dart' as _i19;
import 'transcript.dart' as _i20;
import 'transcript_segment.dart' as _i21;
import 'video_metadata.dart' as _i22;
import 'package:resonance_server/src/generated/podcast.dart' as _i23;
export 'category.dart';
export 'chunk_subtopic_mapping.dart';
export 'conversation_response.dart';
export 'graph_data.dart';
export 'graph_link.dart';
export 'graph_node.dart';
export 'graph_relationship.dart';
export 'ingestion_job.dart';
export 'podcast.dart';
export 'podcast_reference.dart';
export 'podcast_subtopic_evidence.dart';
export 'semantic_chunk.dart';
export 'subtopic.dart';
export 'subtopic_detail.dart';
export 'timestamp_reference.dart';
export 'transcript.dart';
export 'transcript_segment.dart';
export 'video_metadata.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'category',
      dartName: 'Category',
      schema: 'public',
      module: 'resonance',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'category_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'category_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'chunk_subtopic_mapping',
      dartName: 'ChunkSubtopicMapping',
      schema: 'public',
      module: 'resonance',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'chunk_subtopic_mapping_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'chunkId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'subtopicId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'confidence',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.5',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'chunk_subtopic_mapping_fk_0',
          columns: ['chunkId'],
          referenceTable: 'semantic_chunk',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'chunk_subtopic_mapping_fk_1',
          columns: ['subtopicId'],
          referenceTable: 'subtopic',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'chunk_subtopic_mapping_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'graph_relationship',
      dartName: 'GraphRelationship',
      schema: 'public',
      module: 'resonance',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'graph_relationship_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'sourceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'sourceType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'targetId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'targetType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'relationType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'weight',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.5',
        ),
        _i2.ColumnDefinition(
          name: 'metadata',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,String>?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'graph_relationship_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'ingestion_job',
      dartName: 'IngestionJob',
      schema: 'public',
      module: 'resonance',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'ingestion_job_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'podcastId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'stage',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'pending\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'pending\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'errorMessage',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'progress',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'ingestion_job_fk_0',
          columns: ['podcastId'],
          referenceTable: 'podcast',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'ingestion_job_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'podcast',
      dartName: 'Podcast',
      schema: 'public',
      module: 'resonance',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'podcast_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'youtubeUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'videoId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'channelName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'thumbnailUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'podcast_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'podcast_subtopic_evidence',
      dartName: 'PodcastSubtopicEvidence',
      schema: 'public',
      module: 'resonance',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'podcast_subtopic_evidence_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'podcastId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'subtopicId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'frequency',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '1',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'podcast_subtopic_evidence_fk_0',
          columns: ['podcastId'],
          referenceTable: 'podcast',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'podcast_subtopic_evidence_fk_1',
          columns: ['subtopicId'],
          referenceTable: 'subtopic',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'podcast_subtopic_evidence_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'semantic_chunk',
      dartName: 'SemanticChunk',
      schema: 'public',
      module: 'resonance',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'semantic_chunk_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'transcriptId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'podcastId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'startTime',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'endTime',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'text',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'embedding',
          columnType: _i2.ColumnType.vector,
          isNullable: false,
          dartType: 'Vector(768)',
          vectorDimension: 768,
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'semantic_chunk_fk_0',
          columns: ['transcriptId'],
          referenceTable: 'transcript',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'semantic_chunk_fk_1',
          columns: ['podcastId'],
          referenceTable: 'podcast',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'semantic_chunk_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'subtopic',
      dartName: 'Subtopic',
      schema: 'public',
      module: 'resonance',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'subtopic_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'categoryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'secondaryConcepts',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _i2.ColumnDefinition(
          name: 'summary',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'embedding',
          columnType: _i2.ColumnType.vector,
          isNullable: false,
          dartType: 'Vector(768)',
          vectorDimension: 768,
        ),
        _i2.ColumnDefinition(
          name: 'importanceScore',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0.5',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'subtopic_fk_0',
          columns: ['categoryId'],
          referenceTable: 'category',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'subtopic_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'transcript',
      dartName: 'Transcript',
      schema: 'public',
      module: 'resonance',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'transcript_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'podcastId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'videoId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'segments',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:TranscriptSegment>',
        ),
        _i2.ColumnDefinition(
          name: 'isGenerated',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'language',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'transcript_fk_0',
          columns: ['podcastId'],
          referenceTable: 'podcast',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'transcript_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i5.Category) {
      return _i5.Category.fromJson(data) as T;
    }
    if (t == _i6.ChunkSubtopicMapping) {
      return _i6.ChunkSubtopicMapping.fromJson(data) as T;
    }
    if (t == _i7.ConversationResponse) {
      return _i7.ConversationResponse.fromJson(data) as T;
    }
    if (t == _i8.GraphData) {
      return _i8.GraphData.fromJson(data) as T;
    }
    if (t == _i9.GraphLink) {
      return _i9.GraphLink.fromJson(data) as T;
    }
    if (t == _i10.GraphNode) {
      return _i10.GraphNode.fromJson(data) as T;
    }
    if (t == _i11.GraphRelationship) {
      return _i11.GraphRelationship.fromJson(data) as T;
    }
    if (t == _i12.IngestionJob) {
      return _i12.IngestionJob.fromJson(data) as T;
    }
    if (t == _i13.Podcast) {
      return _i13.Podcast.fromJson(data) as T;
    }
    if (t == _i14.PodcastReference) {
      return _i14.PodcastReference.fromJson(data) as T;
    }
    if (t == _i15.PodcastSubtopicEvidence) {
      return _i15.PodcastSubtopicEvidence.fromJson(data) as T;
    }
    if (t == _i16.SemanticChunk) {
      return _i16.SemanticChunk.fromJson(data) as T;
    }
    if (t == _i17.Subtopic) {
      return _i17.Subtopic.fromJson(data) as T;
    }
    if (t == _i18.SubtopicDetail) {
      return _i18.SubtopicDetail.fromJson(data) as T;
    }
    if (t == _i19.TimestampReference) {
      return _i19.TimestampReference.fromJson(data) as T;
    }
    if (t == _i20.Transcript) {
      return _i20.Transcript.fromJson(data) as T;
    }
    if (t == _i21.TranscriptSegment) {
      return _i21.TranscriptSegment.fromJson(data) as T;
    }
    if (t == _i22.VideoMetadata) {
      return _i22.VideoMetadata.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.Category?>()) {
      return (data != null ? _i5.Category.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ChunkSubtopicMapping?>()) {
      return (data != null ? _i6.ChunkSubtopicMapping.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i7.ConversationResponse?>()) {
      return (data != null ? _i7.ConversationResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.GraphData?>()) {
      return (data != null ? _i8.GraphData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.GraphLink?>()) {
      return (data != null ? _i9.GraphLink.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.GraphNode?>()) {
      return (data != null ? _i10.GraphNode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.GraphRelationship?>()) {
      return (data != null ? _i11.GraphRelationship.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.IngestionJob?>()) {
      return (data != null ? _i12.IngestionJob.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.Podcast?>()) {
      return (data != null ? _i13.Podcast.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.PodcastReference?>()) {
      return (data != null ? _i14.PodcastReference.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.PodcastSubtopicEvidence?>()) {
      return (data != null ? _i15.PodcastSubtopicEvidence.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.SemanticChunk?>()) {
      return (data != null ? _i16.SemanticChunk.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.Subtopic?>()) {
      return (data != null ? _i17.Subtopic.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.SubtopicDetail?>()) {
      return (data != null ? _i18.SubtopicDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.TimestampReference?>()) {
      return (data != null ? _i19.TimestampReference.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.Transcript?>()) {
      return (data != null ? _i20.Transcript.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.TranscriptSegment?>()) {
      return (data != null ? _i21.TranscriptSegment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.VideoMetadata?>()) {
      return (data != null ? _i22.VideoMetadata.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i19.TimestampReference>) {
      return (data as List)
              .map((e) => deserialize<_i19.TimestampReference>(e))
              .toList()
          as T;
    }
    if (t == List<_i10.GraphNode>) {
      return (data as List).map((e) => deserialize<_i10.GraphNode>(e)).toList()
          as T;
    }
    if (t == List<_i9.GraphLink>) {
      return (data as List).map((e) => deserialize<_i9.GraphLink>(e)).toList()
          as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == _i1.getType<Map<String, String>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<String>(v)),
                )
              : null)
          as T;
    }
    if (t == List<_i14.PodcastReference>) {
      return (data as List)
              .map((e) => deserialize<_i14.PodcastReference>(e))
              .toList()
          as T;
    }
    if (t == List<_i21.TranscriptSegment>) {
      return (data as List)
              .map((e) => deserialize<_i21.TranscriptSegment>(e))
              .toList()
          as T;
    }
    if (t == List<_i23.Podcast>) {
      return (data as List).map((e) => deserialize<_i23.Podcast>(e)).toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.Category => 'Category',
      _i6.ChunkSubtopicMapping => 'ChunkSubtopicMapping',
      _i7.ConversationResponse => 'ConversationResponse',
      _i8.GraphData => 'GraphData',
      _i9.GraphLink => 'GraphLink',
      _i10.GraphNode => 'GraphNode',
      _i11.GraphRelationship => 'GraphRelationship',
      _i12.IngestionJob => 'IngestionJob',
      _i13.Podcast => 'Podcast',
      _i14.PodcastReference => 'PodcastReference',
      _i15.PodcastSubtopicEvidence => 'PodcastSubtopicEvidence',
      _i16.SemanticChunk => 'SemanticChunk',
      _i17.Subtopic => 'Subtopic',
      _i18.SubtopicDetail => 'SubtopicDetail',
      _i19.TimestampReference => 'TimestampReference',
      _i20.Transcript => 'Transcript',
      _i21.TranscriptSegment => 'TranscriptSegment',
      _i22.VideoMetadata => 'VideoMetadata',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('resonance.', '');
    }

    switch (data) {
      case _i5.Category():
        return 'Category';
      case _i6.ChunkSubtopicMapping():
        return 'ChunkSubtopicMapping';
      case _i7.ConversationResponse():
        return 'ConversationResponse';
      case _i8.GraphData():
        return 'GraphData';
      case _i9.GraphLink():
        return 'GraphLink';
      case _i10.GraphNode():
        return 'GraphNode';
      case _i11.GraphRelationship():
        return 'GraphRelationship';
      case _i12.IngestionJob():
        return 'IngestionJob';
      case _i13.Podcast():
        return 'Podcast';
      case _i14.PodcastReference():
        return 'PodcastReference';
      case _i15.PodcastSubtopicEvidence():
        return 'PodcastSubtopicEvidence';
      case _i16.SemanticChunk():
        return 'SemanticChunk';
      case _i17.Subtopic():
        return 'Subtopic';
      case _i18.SubtopicDetail():
        return 'SubtopicDetail';
      case _i19.TimestampReference():
        return 'TimestampReference';
      case _i20.Transcript():
        return 'Transcript';
      case _i21.TranscriptSegment():
        return 'TranscriptSegment';
      case _i22.VideoMetadata():
        return 'VideoMetadata';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Category') {
      return deserialize<_i5.Category>(data['data']);
    }
    if (dataClassName == 'ChunkSubtopicMapping') {
      return deserialize<_i6.ChunkSubtopicMapping>(data['data']);
    }
    if (dataClassName == 'ConversationResponse') {
      return deserialize<_i7.ConversationResponse>(data['data']);
    }
    if (dataClassName == 'GraphData') {
      return deserialize<_i8.GraphData>(data['data']);
    }
    if (dataClassName == 'GraphLink') {
      return deserialize<_i9.GraphLink>(data['data']);
    }
    if (dataClassName == 'GraphNode') {
      return deserialize<_i10.GraphNode>(data['data']);
    }
    if (dataClassName == 'GraphRelationship') {
      return deserialize<_i11.GraphRelationship>(data['data']);
    }
    if (dataClassName == 'IngestionJob') {
      return deserialize<_i12.IngestionJob>(data['data']);
    }
    if (dataClassName == 'Podcast') {
      return deserialize<_i13.Podcast>(data['data']);
    }
    if (dataClassName == 'PodcastReference') {
      return deserialize<_i14.PodcastReference>(data['data']);
    }
    if (dataClassName == 'PodcastSubtopicEvidence') {
      return deserialize<_i15.PodcastSubtopicEvidence>(data['data']);
    }
    if (dataClassName == 'SemanticChunk') {
      return deserialize<_i16.SemanticChunk>(data['data']);
    }
    if (dataClassName == 'Subtopic') {
      return deserialize<_i17.Subtopic>(data['data']);
    }
    if (dataClassName == 'SubtopicDetail') {
      return deserialize<_i18.SubtopicDetail>(data['data']);
    }
    if (dataClassName == 'TimestampReference') {
      return deserialize<_i19.TimestampReference>(data['data']);
    }
    if (dataClassName == 'Transcript') {
      return deserialize<_i20.Transcript>(data['data']);
    }
    if (dataClassName == 'TranscriptSegment') {
      return deserialize<_i21.TranscriptSegment>(data['data']);
    }
    if (dataClassName == 'VideoMetadata') {
      return deserialize<_i22.VideoMetadata>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i4.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i5.Category:
        return _i5.Category.t;
      case _i6.ChunkSubtopicMapping:
        return _i6.ChunkSubtopicMapping.t;
      case _i11.GraphRelationship:
        return _i11.GraphRelationship.t;
      case _i12.IngestionJob:
        return _i12.IngestionJob.t;
      case _i13.Podcast:
        return _i13.Podcast.t;
      case _i15.PodcastSubtopicEvidence:
        return _i15.PodcastSubtopicEvidence.t;
      case _i16.SemanticChunk:
        return _i16.SemanticChunk.t;
      case _i17.Subtopic:
        return _i17.Subtopic.t;
      case _i20.Transcript:
        return _i20.Transcript.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'resonance';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
