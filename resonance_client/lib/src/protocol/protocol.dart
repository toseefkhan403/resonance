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
import 'chunk_subtopic_mapping.dart' as _i3;
import 'conversation_response.dart' as _i4;
import 'graph_data.dart' as _i5;
import 'graph_link.dart' as _i6;
import 'graph_node.dart' as _i7;
import 'graph_relationship.dart' as _i8;
import 'ingestion_job.dart' as _i9;
import 'podcast.dart' as _i10;
import 'podcast_reference.dart' as _i11;
import 'podcast_subtopic_evidence.dart' as _i12;
import 'semantic_chunk.dart' as _i13;
import 'subtopic.dart' as _i14;
import 'subtopic_detail.dart' as _i15;
import 'timestamp_reference.dart' as _i16;
import 'transcript.dart' as _i17;
import 'transcript_segment.dart' as _i18;
import 'video_metadata.dart' as _i19;
import 'package:resonance_client/src/protocol/podcast.dart' as _i20;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i21;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i22;
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
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

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

    if (t == _i2.Category) {
      return _i2.Category.fromJson(data) as T;
    }
    if (t == _i3.ChunkSubtopicMapping) {
      return _i3.ChunkSubtopicMapping.fromJson(data) as T;
    }
    if (t == _i4.ConversationResponse) {
      return _i4.ConversationResponse.fromJson(data) as T;
    }
    if (t == _i5.GraphData) {
      return _i5.GraphData.fromJson(data) as T;
    }
    if (t == _i6.GraphLink) {
      return _i6.GraphLink.fromJson(data) as T;
    }
    if (t == _i7.GraphNode) {
      return _i7.GraphNode.fromJson(data) as T;
    }
    if (t == _i8.GraphRelationship) {
      return _i8.GraphRelationship.fromJson(data) as T;
    }
    if (t == _i9.IngestionJob) {
      return _i9.IngestionJob.fromJson(data) as T;
    }
    if (t == _i10.Podcast) {
      return _i10.Podcast.fromJson(data) as T;
    }
    if (t == _i11.PodcastReference) {
      return _i11.PodcastReference.fromJson(data) as T;
    }
    if (t == _i12.PodcastSubtopicEvidence) {
      return _i12.PodcastSubtopicEvidence.fromJson(data) as T;
    }
    if (t == _i13.SemanticChunk) {
      return _i13.SemanticChunk.fromJson(data) as T;
    }
    if (t == _i14.Subtopic) {
      return _i14.Subtopic.fromJson(data) as T;
    }
    if (t == _i15.SubtopicDetail) {
      return _i15.SubtopicDetail.fromJson(data) as T;
    }
    if (t == _i16.TimestampReference) {
      return _i16.TimestampReference.fromJson(data) as T;
    }
    if (t == _i17.Transcript) {
      return _i17.Transcript.fromJson(data) as T;
    }
    if (t == _i18.TranscriptSegment) {
      return _i18.TranscriptSegment.fromJson(data) as T;
    }
    if (t == _i19.VideoMetadata) {
      return _i19.VideoMetadata.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Category?>()) {
      return (data != null ? _i2.Category.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.ChunkSubtopicMapping?>()) {
      return (data != null ? _i3.ChunkSubtopicMapping.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i4.ConversationResponse?>()) {
      return (data != null ? _i4.ConversationResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i5.GraphData?>()) {
      return (data != null ? _i5.GraphData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.GraphLink?>()) {
      return (data != null ? _i6.GraphLink.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.GraphNode?>()) {
      return (data != null ? _i7.GraphNode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.GraphRelationship?>()) {
      return (data != null ? _i8.GraphRelationship.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.IngestionJob?>()) {
      return (data != null ? _i9.IngestionJob.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Podcast?>()) {
      return (data != null ? _i10.Podcast.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.PodcastReference?>()) {
      return (data != null ? _i11.PodcastReference.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.PodcastSubtopicEvidence?>()) {
      return (data != null ? _i12.PodcastSubtopicEvidence.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.SemanticChunk?>()) {
      return (data != null ? _i13.SemanticChunk.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Subtopic?>()) {
      return (data != null ? _i14.Subtopic.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.SubtopicDetail?>()) {
      return (data != null ? _i15.SubtopicDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.TimestampReference?>()) {
      return (data != null ? _i16.TimestampReference.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.Transcript?>()) {
      return (data != null ? _i17.Transcript.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.TranscriptSegment?>()) {
      return (data != null ? _i18.TranscriptSegment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.VideoMetadata?>()) {
      return (data != null ? _i19.VideoMetadata.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i16.TimestampReference>) {
      return (data as List)
              .map((e) => deserialize<_i16.TimestampReference>(e))
              .toList()
          as T;
    }
    if (t == List<_i7.GraphNode>) {
      return (data as List).map((e) => deserialize<_i7.GraphNode>(e)).toList()
          as T;
    }
    if (t == List<_i6.GraphLink>) {
      return (data as List).map((e) => deserialize<_i6.GraphLink>(e)).toList()
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
    if (t == List<_i11.PodcastReference>) {
      return (data as List)
              .map((e) => deserialize<_i11.PodcastReference>(e))
              .toList()
          as T;
    }
    if (t == List<_i18.TranscriptSegment>) {
      return (data as List)
              .map((e) => deserialize<_i18.TranscriptSegment>(e))
              .toList()
          as T;
    }
    if (t == List<_i20.Podcast>) {
      return (data as List).map((e) => deserialize<_i20.Podcast>(e)).toList()
          as T;
    }
    try {
      return _i21.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i22.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.Category => 'Category',
      _i3.ChunkSubtopicMapping => 'ChunkSubtopicMapping',
      _i4.ConversationResponse => 'ConversationResponse',
      _i5.GraphData => 'GraphData',
      _i6.GraphLink => 'GraphLink',
      _i7.GraphNode => 'GraphNode',
      _i8.GraphRelationship => 'GraphRelationship',
      _i9.IngestionJob => 'IngestionJob',
      _i10.Podcast => 'Podcast',
      _i11.PodcastReference => 'PodcastReference',
      _i12.PodcastSubtopicEvidence => 'PodcastSubtopicEvidence',
      _i13.SemanticChunk => 'SemanticChunk',
      _i14.Subtopic => 'Subtopic',
      _i15.SubtopicDetail => 'SubtopicDetail',
      _i16.TimestampReference => 'TimestampReference',
      _i17.Transcript => 'Transcript',
      _i18.TranscriptSegment => 'TranscriptSegment',
      _i19.VideoMetadata => 'VideoMetadata',
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
      case _i2.Category():
        return 'Category';
      case _i3.ChunkSubtopicMapping():
        return 'ChunkSubtopicMapping';
      case _i4.ConversationResponse():
        return 'ConversationResponse';
      case _i5.GraphData():
        return 'GraphData';
      case _i6.GraphLink():
        return 'GraphLink';
      case _i7.GraphNode():
        return 'GraphNode';
      case _i8.GraphRelationship():
        return 'GraphRelationship';
      case _i9.IngestionJob():
        return 'IngestionJob';
      case _i10.Podcast():
        return 'Podcast';
      case _i11.PodcastReference():
        return 'PodcastReference';
      case _i12.PodcastSubtopicEvidence():
        return 'PodcastSubtopicEvidence';
      case _i13.SemanticChunk():
        return 'SemanticChunk';
      case _i14.Subtopic():
        return 'Subtopic';
      case _i15.SubtopicDetail():
        return 'SubtopicDetail';
      case _i16.TimestampReference():
        return 'TimestampReference';
      case _i17.Transcript():
        return 'Transcript';
      case _i18.TranscriptSegment():
        return 'TranscriptSegment';
      case _i19.VideoMetadata():
        return 'VideoMetadata';
    }
    className = _i21.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i22.Protocol().getClassNameForObject(data);
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
      return deserialize<_i2.Category>(data['data']);
    }
    if (dataClassName == 'ChunkSubtopicMapping') {
      return deserialize<_i3.ChunkSubtopicMapping>(data['data']);
    }
    if (dataClassName == 'ConversationResponse') {
      return deserialize<_i4.ConversationResponse>(data['data']);
    }
    if (dataClassName == 'GraphData') {
      return deserialize<_i5.GraphData>(data['data']);
    }
    if (dataClassName == 'GraphLink') {
      return deserialize<_i6.GraphLink>(data['data']);
    }
    if (dataClassName == 'GraphNode') {
      return deserialize<_i7.GraphNode>(data['data']);
    }
    if (dataClassName == 'GraphRelationship') {
      return deserialize<_i8.GraphRelationship>(data['data']);
    }
    if (dataClassName == 'IngestionJob') {
      return deserialize<_i9.IngestionJob>(data['data']);
    }
    if (dataClassName == 'Podcast') {
      return deserialize<_i10.Podcast>(data['data']);
    }
    if (dataClassName == 'PodcastReference') {
      return deserialize<_i11.PodcastReference>(data['data']);
    }
    if (dataClassName == 'PodcastSubtopicEvidence') {
      return deserialize<_i12.PodcastSubtopicEvidence>(data['data']);
    }
    if (dataClassName == 'SemanticChunk') {
      return deserialize<_i13.SemanticChunk>(data['data']);
    }
    if (dataClassName == 'Subtopic') {
      return deserialize<_i14.Subtopic>(data['data']);
    }
    if (dataClassName == 'SubtopicDetail') {
      return deserialize<_i15.SubtopicDetail>(data['data']);
    }
    if (dataClassName == 'TimestampReference') {
      return deserialize<_i16.TimestampReference>(data['data']);
    }
    if (dataClassName == 'Transcript') {
      return deserialize<_i17.Transcript>(data['data']);
    }
    if (dataClassName == 'TranscriptSegment') {
      return deserialize<_i18.TranscriptSegment>(data['data']);
    }
    if (dataClassName == 'VideoMetadata') {
      return deserialize<_i19.VideoMetadata>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i21.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i22.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

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
      return _i21.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i22.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
