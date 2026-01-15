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

abstract class Podcast implements _i1.SerializableModel {
  Podcast._({
    this.id,
    required this.youtubeUrl,
    required this.videoId,
    this.title,
    this.channelName,
    this.thumbnailUrl,
    required this.userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Podcast({
    int? id,
    required String youtubeUrl,
    required String videoId,
    String? title,
    String? channelName,
    String? thumbnailUrl,
    required String userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _PodcastImpl;

  factory Podcast.fromJson(Map<String, dynamic> jsonSerialization) {
    return Podcast(
      id: jsonSerialization['id'] as int?,
      youtubeUrl: jsonSerialization['youtubeUrl'] as String,
      videoId: jsonSerialization['videoId'] as String,
      title: jsonSerialization['title'] as String?,
      channelName: jsonSerialization['channelName'] as String?,
      thumbnailUrl: jsonSerialization['thumbnailUrl'] as String?,
      userId: jsonSerialization['userId'] as String,
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

  /// The YouTube URL of the podcast
  String youtubeUrl;

  /// The unique YouTube Video ID
  String videoId;

  /// The title of the podcast (extracted from YouTube)
  String? title;

  /// The channel name
  String? channelName;

  /// The thumbnail URL
  String? thumbnailUrl;

  /// The user who owns this podcast
  String userId;

  /// When the podcast was first ingested
  DateTime createdAt;

  /// When the podcast was last updated
  DateTime updatedAt;

  /// Returns a shallow copy of this [Podcast]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Podcast copyWith({
    int? id,
    String? youtubeUrl,
    String? videoId,
    String? title,
    String? channelName,
    String? thumbnailUrl,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Podcast',
      if (id != null) 'id': id,
      'youtubeUrl': youtubeUrl,
      'videoId': videoId,
      if (title != null) 'title': title,
      if (channelName != null) 'channelName': channelName,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
      'userId': userId,
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

class _PodcastImpl extends Podcast {
  _PodcastImpl({
    int? id,
    required String youtubeUrl,
    required String videoId,
    String? title,
    String? channelName,
    String? thumbnailUrl,
    required String userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         youtubeUrl: youtubeUrl,
         videoId: videoId,
         title: title,
         channelName: channelName,
         thumbnailUrl: thumbnailUrl,
         userId: userId,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Podcast]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Podcast copyWith({
    Object? id = _Undefined,
    String? youtubeUrl,
    String? videoId,
    Object? title = _Undefined,
    Object? channelName = _Undefined,
    Object? thumbnailUrl = _Undefined,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Podcast(
      id: id is int? ? id : this.id,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      videoId: videoId ?? this.videoId,
      title: title is String? ? title : this.title,
      channelName: channelName is String? ? channelName : this.channelName,
      thumbnailUrl: thumbnailUrl is String? ? thumbnailUrl : this.thumbnailUrl,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
