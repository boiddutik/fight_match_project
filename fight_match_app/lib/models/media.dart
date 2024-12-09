import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

enum MediaType {
  image('image'),
  video('video'),
  audio('audio'),
  document('document');

  final String type;
  const MediaType(this.type);
}

extension ConvertMediaType on String {
  MediaType toMediaTypeEnum() {
    switch (this) {
      case 'image':
        return MediaType.image;
      case 'video':
        return MediaType.video;
      case 'audio':
        return MediaType.audio;
      case 'document':
        return MediaType.document;
      default:
        return MediaType.image;
    }
  }
}
// -----------------------------------------------------------------------------

class Media {
  final String? mediaId;
  final MediaType? mediaType;
  final String? mediaDescription;
  final String? mediaUrl;
  final List<String>? likes;
  final List<String>? unLikes;
  final List<String>? comments;
  final List<String>? shares;
  final List<String>? views;
  final List<String>? reports;
  final File? mediaFile;

  Media({
    this.mediaId,
    this.mediaType,
    this.mediaDescription,
    this.mediaUrl,
    this.likes,
    this.unLikes,
    this.comments,
    this.shares,
    this.views,
    this.reports,
    this.mediaFile,
  });

  Media copyWith({
    String? mediaId,
    MediaType? mediaType,
    String? mediaDescription,
    String? mediaUrl,
    List<String>? likes,
    List<String>? unLikes,
    List<String>? comments,
    List<String>? shares,
    List<String>? views,
    List<String>? reports,
    File? mediaFile,
  }) {
    return Media(
      mediaId: mediaId ?? this.mediaId,
      mediaType: mediaType ?? this.mediaType,
      mediaDescription: mediaDescription ?? this.mediaDescription,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      likes: likes ?? this.likes,
      unLikes: unLikes ?? this.unLikes,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
      views: views ?? this.views,
      reports: reports ?? this.reports,
      mediaFile: mediaFile ?? this.mediaFile,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    if (mediaId != null) {
      result.addAll({'mediaId': mediaId});
    }
    if (mediaType != null) {
      result.addAll({'mediaType': mediaType!.type});
    }
    if (mediaDescription != null) {
      result.addAll({'mediaDescription': mediaDescription});
    }
    if (mediaUrl != null) {
      result.addAll({'mediaUrl': mediaUrl});
    }
    if (likes != null) {
      result.addAll({'likes': likes});
    }
    if (unLikes != null) {
      result.addAll({'unLikes': unLikes});
    }
    if (comments != null) {
      result.addAll({'comments': comments});
    }
    if (shares != null) {
      result.addAll({'shares': shares});
    }
    if (views != null) {
      result.addAll({'views': views});
    }
    if (reports != null) {
      result.addAll({'reports': reports});
    }
    // mediaFile is intentionally not included in the JSON map
    return result;
  }

  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
      mediaId: map['mediaId'] ?? map['_id'],
      mediaType: (map['mediaType'] as String).toMediaTypeEnum(),
      mediaDescription: map['mediaDescription'],
      mediaUrl: map['mediaUrl'],
      likes: List<String>.from(map['likes']),
      unLikes: List<String>.from(map['unLikes']),
      comments: List<String>.from(map['comments']),
      shares: List<String>.from(map['shares']),
      views: List<String>.from(map['views']),
      reports: List<String>.from(map['reports']),
      // mediaFile cannot be reconstructed from JSON
    );
  }

  String toJson() => json.encode(toMap());

  factory Media.fromJson(String source) => Media.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Media(mediaType: $mediaType, mediaId: $mediaId, mediaDescription: $mediaDescription, mediaUrl: $mediaUrl, likes: $likes, unLikes: $unLikes, comments: $comments, shares: $shares, views: $views, reports: $reports, mediaFile: $mediaFile)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Media &&
        other.mediaType == mediaType &&
        other.mediaId == mediaId &&
        other.mediaDescription == mediaDescription &&
        other.mediaUrl == mediaUrl &&
        listEquals(other.likes, likes) &&
        listEquals(other.unLikes, unLikes) &&
        listEquals(other.comments, comments) &&
        listEquals(other.shares, shares) &&
        listEquals(other.views, views) &&
        listEquals(other.reports, reports) &&
        other.mediaFile == mediaFile;
  }

  @override
  int get hashCode {
    return mediaType.hashCode ^
        mediaId.hashCode ^
        mediaDescription.hashCode ^
        mediaUrl.hashCode ^
        likes.hashCode ^
        unLikes.hashCode ^
        comments.hashCode ^
        shares.hashCode ^
        views.hashCode ^
        reports.hashCode ^
        mediaFile.hashCode;
  }
}
