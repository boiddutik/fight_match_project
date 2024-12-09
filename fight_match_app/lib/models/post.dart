import 'dart:convert';
import 'package:fight_match_app/models/media.dart';
import 'package:flutter/foundation.dart';

// -----------------------------------------------------------------------------

enum PostType {
  post('post'),
  highlight('highlight'),
  event('event'),
  reel('reel');

  final String type;
  const PostType(this.type);
}

extension ConvertPostType on String {
  PostType toPostTypeEnum() {
    switch (this) {
      case 'post':
        return PostType.post;
      case 'highlight':
        return PostType.highlight;
      case 'event':
        return PostType.event;
      case 'reel':
        return PostType.reel;
      default:
        throw ArgumentError('Invalid post type: $this');
    }
  }
}

// -----------------------------------------------------------------------------

enum PrivacyType {
  public('public'),
  private('private');

  final String type;
  const PrivacyType(this.type);
}

extension ConvertPrivacyType on String {
  PrivacyType toPrivacyTypeEnum() {
    switch (this) {
      case 'public':
        return PrivacyType.public;
      case 'private':
        return PrivacyType.private;
      default:
        throw ArgumentError('Invalid privacy type: $this');
    }
  }
}

// -----------------------------------------------------------------------------

class Post {
  final String? postId;
  final PostType postType;
  final PrivacyType privacyType;
  final String creatorUserId;
  final String creatorUserName;
  final String creatorProfileId;
  final String creatorFullName;
  final String creatorAvatar;
  final String caption;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Media>? medium;
  final List<String>? likes;
  final List<String>? unLikes;
  final List<String>? comments;
  final List<String>? shares;
  final List<String>? views;
  final List<String>? reports;
  final List<String>? associates;
  final String? eventVenue;
  final double? eventLatitude;
  final double? eventLongitude;
  final DateTime? eventDate;

  Post({
    this.postId,
    required this.postType,
    required this.privacyType,
    required this.creatorUserId,
    required this.creatorUserName,
    required this.creatorProfileId,
    required this.creatorFullName,
    required this.creatorAvatar,
    required this.caption,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.medium,
    this.likes,
    this.unLikes,
    this.comments,
    this.shares,
    this.views,
    this.reports,
    this.associates,
    this.eventVenue,
    this.eventLatitude,
    this.eventLongitude,
    this.eventDate,
  });

  Post copyWith({
    String? postId,
    PostType? postType,
    PrivacyType? privacyType,
    String? creatorUserId,
    String? creatorUserName,
    String? creatorProfileId,
    String? creatorFullName,
    String? creatorAvatar,
    String? caption,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Media>? medium,
    List<String>? likes,
    List<String>? unLikes,
    List<String>? comments,
    List<String>? shares,
    List<String>? views,
    List<String>? reports,
    List<String>? associates,
    String? eventVenue,
    double? eventLatitude,
    double? eventLongitude,
    DateTime? eventDate,
  }) {
    return Post(
      postId: postId ?? this.postId,
      postType: postType ?? this.postType,
      privacyType: privacyType ?? this.privacyType,
      creatorUserId: creatorUserId ?? this.creatorUserId,
      creatorUserName: creatorUserName ?? this.creatorUserName,
      creatorProfileId: creatorProfileId ?? this.creatorProfileId,
      creatorFullName: creatorFullName ?? this.creatorFullName,
      creatorAvatar: creatorAvatar ?? this.creatorAvatar,
      caption: caption ?? this.caption,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      medium: medium ?? this.medium,
      likes: likes ?? this.likes,
      unLikes: unLikes ?? this.unLikes,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
      views: views ?? this.views,
      reports: reports ?? this.reports,
      associates: associates ?? this.associates,
      eventVenue: eventVenue ?? this.eventVenue,
      eventLatitude: eventLatitude ?? this.eventLatitude,
      eventLongitude: eventLongitude ?? this.eventLongitude,
      eventDate: eventDate ?? this.eventDate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (postId != null) result['postId'] = postId;
    result['postType'] = postType.type;
    result['privacyType'] = privacyType.type;
    result['creatorUserId'] = creatorUserId;
    result['creatorUserName'] = creatorUserName;
    result['creatorProfileId'] = creatorProfileId;
    result['creatorFullName'] = creatorFullName;
    result['creatorAvatar'] = creatorAvatar;
    result['caption'] = caption;
    if (description != null) result['description'] = description;
    if (createdAt != null) result['createdAt'] = createdAt!.toIso8601String();
    if (updatedAt != null) result['updatedAt'] = updatedAt!.toIso8601String();
    if (medium != null) {
      result['medium'] = medium!.map((x) => x.toMap()).toList();
    }
    if (likes != null) result['likes'] = likes;
    if (unLikes != null) result['unLikes'] = unLikes;
    if (comments != null) result['comments'] = comments;
    if (shares != null) result['shares'] = shares;
    if (views != null) result['views'] = views;
    if (reports != null) result['reports'] = reports;
    if (associates != null) result['associates'] = associates;
    if (eventVenue != null) result['eventVenue'] = eventVenue;
    if (eventLatitude != null) result['eventLatitude'] = eventLatitude;
    if (eventLongitude != null) result['eventLongitude'] = eventLongitude;
    if (eventDate != null) result['eventDate'] = eventDate!.toIso8601String();

    return result;
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    if (!map.containsKey('postType') || !map.containsKey('privacyType')) {
      throw ArgumentError('Missing required fields: postType or privacyType');
    }

    return Post(
      postId: map['postId'] ?? map['_id'],
      postType: (map['postType'] as String).toPostTypeEnum(),
      privacyType: (map['privacyType'] as String).toPrivacyTypeEnum(),
      creatorUserId: map['creatorUserId'] ?? '',
      creatorUserName: map['creatorUserName'] ?? '',
      creatorProfileId: map['creatorProfileId'] ?? '',
      creatorFullName: map['creatorFullName'] ?? '',
      creatorAvatar: map['creatorAvatar'] ?? '',
      caption: map['caption'] ?? '',
      description: map['description'],
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      medium: map['medium'] != null
          ? List<Media>.from(map['medium'].map((x) => Media.fromMap(x)))
          : [],
      likes: map['likes'] != null ? List<String>.from(map['likes']) : [],
      unLikes: map['unLikes'] != null ? List<String>.from(map['unLikes']) : [],
      comments:
          map['comments'] != null ? List<String>.from(map['comments']) : [],
      shares: map['shares'] != null ? List<String>.from(map['shares']) : [],
      views: map['views'] != null ? List<String>.from(map['views']) : [],
      reports: map['reports'] != null ? List<String>.from(map['reports']) : [],
      associates:
          map['associates'] != null ? List<String>.from(map['associates']) : [],
      eventVenue: map['eventVenue'],
      eventLatitude: map['eventLatitude']?.toDouble(),
      eventLongitude: map['eventLongitude']?.toDouble(),
      eventDate:
          map['eventDate'] != null ? DateTime.parse(map['eventDate']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(postId: $postId, postType: $postType, privacyType: $privacyType, creatorUserId: $creatorUserId, creatorUserName: $creatorUserName, creatorProfileId: $creatorProfileId, creatorFullName: $creatorFullName, creatorAvatar: $creatorAvatar, caption: $caption, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, medium: $medium, likes: $likes, unLikes: $unLikes, comments: $comments, shares: $shares, views: $views, reports: $reports, associates: $associates, eventVenue: $eventVenue, eventLatitude: $eventLatitude, eventLongitude: $eventLongitude, eventDate: $eventDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Post) return false;

    return postId == other.postId &&
        postType == other.postType &&
        privacyType == other.privacyType &&
        creatorUserId == other.creatorUserId &&
        creatorUserName == other.creatorUserName &&
        creatorProfileId == other.creatorProfileId &&
        creatorFullName == other.creatorFullName &&
        creatorAvatar == other.creatorAvatar &&
        caption == other.caption &&
        description == other.description &&
        listEquals(likes, other.likes) &&
        listEquals(unLikes, other.unLikes) &&
        listEquals(comments, other.comments) &&
        listEquals(shares, other.shares) &&
        listEquals(views, other.views) &&
        listEquals(reports, other.reports) &&
        listEquals(associates, other.associates) &&
        eventVenue == other.eventVenue &&
        eventLatitude == other.eventLatitude &&
        eventLongitude == other.eventLongitude &&
        eventDate == other.eventDate;
  }

  @override
  int get hashCode {
    return postId.hashCode ^
        postType.hashCode ^
        privacyType.hashCode ^
        creatorUserId.hashCode ^
        creatorUserName.hashCode ^
        creatorProfileId.hashCode ^
        creatorFullName.hashCode ^
        creatorAvatar.hashCode ^
        caption.hashCode ^
        description.hashCode ^
        likes.hashCode ^
        unLikes.hashCode ^
        comments.hashCode ^
        shares.hashCode ^
        views.hashCode ^
        reports.hashCode ^
        associates.hashCode ^
        eventVenue.hashCode ^
        eventLatitude.hashCode ^
        eventLongitude.hashCode ^
        eventDate.hashCode;
  }
}

// import 'dart:convert';

// import 'package:fight_match_app/models/media.dart';
// import 'package:flutter/foundation.dart';



// enum PostType {
//   post('post'),
//   highlight('highlight'),
//   event('event'),
//   reel('reel');

//   final String type;
//   const PostType(this.type);
// }

// extension ConvertPostType on String {
//   PostType toPostTypeEnum() {
//     switch (this) {
//       case 'post':
//         return PostType.post;
//       case 'highlight':
//         return PostType.highlight;
//       case 'event':
//         return PostType.event;
//       case 'reel':
//         return PostType.reel;
//       default:
//         return PostType.post;
//     }
//   }
// }
// // -----------------------------------------------------------------------------

// enum PrivacyType {
//   public('public'),
//   private('private');

//   final String type;
//   const PrivacyType(this.type);
// }

// extension ConvertPrivacyType on String {
//   PrivacyType toPrivacyTypeEnum() {
//     switch (this) {
//       case 'public':
//         return PrivacyType.public;
//       case 'private':
//         return PrivacyType.private;
//       default:
//         return PrivacyType.public;
//     }
//   }
// }

// // -----------------------------------------------------------------------------
// class Post {
//   final String? postId;
//   final PostType postType;
//   final PrivacyType privacyType;
//   final String creatorUserId;
//   final String creatorUserName;
//   final String creatorProfileId;
//   final String creatorFullName;
//   final String creatorAvatar;
//   final String caption;
//   final String? description;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final List<Media>? medium;
//   final List<String>? likes;
//   final List<String>? unLikes;
//   final List<String>? comments;
//   final List<String>? shares;
//   final List<String>? views;
//   final List<String>? reports;
//   final List<String>? associates;
//   final String? eventVenue;
//   final double? eventLatitude;
//   final double? eventLongitude;
//   final DateTime? eventDate;
//   Post({
//     this.postId,
//     required this.postType,
//     required this.privacyType,
//     required this.creatorUserId,
//     required this.creatorUserName,
//     required this.creatorProfileId,
//     required this.creatorFullName,
//     required this.creatorAvatar,
//     required this.caption,
//     this.description,
//     this.createdAt,
//     this.updatedAt,
//     this.medium,
//     this.likes,
//     this.unLikes,
//     this.comments,
//     this.shares,
//     this.views,
//     this.reports,
//     this.associates,
//     this.eventVenue,
//     this.eventLatitude,
//     this.eventLongitude,
//     this.eventDate,
//   });

//   Post copyWith({
//     String? postId,
//     PostType? postType,
//     PrivacyType? privacyType,
//     String? creatorUserId,
//     String? creatorUserName,
//     String? creatorProfileId,
//     String? creatorFullName,
//     String? creatorAvatar,
//     String? caption,
//     String? description,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     List<Media>? medium,
//     List<String>? likes,
//     List<String>? unLikes,
//     List<String>? comments,
//     List<String>? shares,
//     List<String>? views,
//     List<String>? reports,
//     List<String>? associates,
//     String? eventVenue,
//     double? eventLatitude,
//     double? eventLongitude,
//     DateTime? eventDate,
//   }) {
//     return Post(
//       postId: postId ?? this.postId,
//       postType: postType ?? this.postType,
//       privacyType: privacyType ?? this.privacyType,
//       creatorUserId: creatorUserId ?? this.creatorUserId,
//       creatorUserName: creatorUserName ?? this.creatorUserName,
//       creatorProfileId: creatorProfileId ?? this.creatorProfileId,
//       creatorFullName: creatorFullName ?? this.creatorFullName,
//       creatorAvatar: creatorAvatar ?? this.creatorAvatar,
//       caption: caption ?? this.caption,
//       description: description ?? this.description,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//       medium: medium ?? this.medium,
//       likes: likes ?? this.likes,
//       unLikes: unLikes ?? this.unLikes,
//       comments: comments ?? this.comments,
//       shares: shares ?? this.shares,
//       views: views ?? this.views,
//       reports: reports ?? this.reports,
//       associates: associates ?? this.associates,
//       eventVenue: eventVenue ?? this.eventVenue,
//       eventLatitude: eventLatitude ?? this.eventLatitude,
//       eventLongitude: eventLongitude ?? this.eventLongitude,
//       eventDate: eventDate ?? this.eventDate,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     final result = <String, dynamic>{};

//     if (postId != null) {
//       result.addAll({'postId': postId});
//     }
//     result.addAll({'postType': postType.type});
//     result.addAll({'privacy': privacyType.type});
//     result.addAll({'creatorUserId': creatorUserId});
//     result.addAll({'creatorUserName': creatorUserName});
//     result.addAll({'creatorProfileId': creatorProfileId});
//     result.addAll({'creatorFullName': creatorFullName});
//     result.addAll({'creatorAvatar': creatorAvatar});
//     result.addAll({'caption': caption});
//     if (description != null) {
//       result.addAll({'description': description});
//     }
//     if (createdAt != null) {
//       result.addAll({'createdAt': createdAt!.toIso8601String()});
//     }
//     if (updatedAt != null) {
//       result.addAll({'updatedAt': updatedAt!.toIso8601String()});
//     }
//     if (medium != null) {
//       result.addAll({'medium': medium!.map((x) => x.toMap()).toList()});
//     }
//     if (likes != null) {
//       result.addAll({'likes': likes});
//     }
//     if (unLikes != null) {
//       result.addAll({'unLikes': unLikes});
//     }
//     if (comments != null) {
//       result.addAll({'comments': comments});
//     }
//     if (shares != null) {
//       result.addAll({'shares': shares});
//     }
//     if (views != null) {
//       result.addAll({'views': views});
//     }
//     if (reports != null) {
//       result.addAll({'reports': reports});
//     }
//     if (associates != null) {
//       result.addAll({'associates': associates});
//     }
//     if (eventVenue != null) {
//       result.addAll({'eventVenue': eventVenue});
//     }
//     if (eventLatitude != null) {
//       result.addAll({'eventLatitude': eventLatitude});
//     }
//     if (eventLongitude != null) {
//       result.addAll({'eventLongitude': eventLongitude});
//     }
//     if (eventDate != null) {
//       result.addAll({'eventDate': eventDate!.toIso8601String()});
//     }

//     return result;
//   }

//   factory Post.fromMap(Map<String, dynamic> map) {
//     return Post(
//       postId: map['postId'] ?? map['_id'],
//       postType: (map['postType'] as String).toPostTypeEnum(),
//       privacyType: (map['privacyType'] as String).toPrivacyTypeEnum(),
//       creatorUserId: map['creatorUserId'] ?? '',
//       creatorUserName: map['creatorUserName'] ?? '',
//       creatorProfileId: map['creatorProfileId'] ?? '',
//       creatorFullName: map['creatorFullName'] ?? '',
//       creatorAvatar: map['creatorAvatar'] ?? '',
//       caption: map['caption'] ?? '',
//       description: map['description'],
//       createdAt:
//           map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
//       updatedAt:
//           map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
//       medium: map['medium'] != null
//           ? List<Media>.from(map['medium']?.map((x) => Media.fromMap(x)))
//           : null,
//       likes: List<String>.from(map['likes']),
//       unLikes: List<String>.from(map['unLikes']),
//       comments: List<String>.from(map['comments']),
//       shares: List<String>.from(map['shares']),
//       views: List<String>.from(map['views']),
//       reports: List<String>.from(map['reports']),
//       associates: List<String>.from(map['associates']),
//       eventVenue: map['eventVenue'],
//       eventLatitude: map['eventLatitude']?.toDouble(),
//       eventLongitude: map['eventLongitude']?.toDouble(),
//       eventDate:
//           map['eventDate'] != null ? DateTime.parse(map['eventDate']) : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'Post(postId: $postId, postType: $postType, privacyType: $privacyType, creatorUserId: $creatorUserId, creatorUserName: $creatorUserName, creatorProfileId: $creatorProfileId, creatorFullName: $creatorFullName, creatorAvatar: $creatorAvatar, caption: $caption, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, medium: $medium, likes: $likes, unLikes: $unLikes, comments: $comments, shares: $shares, views: $views, reports: $reports, associates: $associates, eventVenue: $eventVenue, eventLatitude: $eventLatitude, eventLongitude: $eventLongitude, eventDate: $eventDate)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is Post &&
//         other.postId == postId &&
//         other.postType == postType &&
//         other.privacyType == privacyType &&
//         other.creatorUserId == creatorUserId &&
//         other.creatorUserName == creatorUserName &&
//         other.creatorProfileId == creatorProfileId &&
//         other.creatorFullName == creatorFullName &&
//         other.creatorAvatar == creatorAvatar &&
//         other.caption == caption &&
//         other.description == description &&
//         other.createdAt == createdAt &&
//         other.updatedAt == updatedAt &&
//         listEquals(other.medium, medium) &&
//         listEquals(other.likes, likes) &&
//         listEquals(other.unLikes, unLikes) &&
//         listEquals(other.comments, comments) &&
//         listEquals(other.shares, shares) &&
//         listEquals(other.views, views) &&
//         listEquals(other.reports, reports) &&
//         listEquals(other.associates, associates) &&
//         other.eventVenue == eventVenue &&
//         other.eventLatitude == eventLatitude &&
//         other.eventLongitude == eventLongitude &&
//         other.eventDate == eventDate;
//   }

//   @override
//   int get hashCode {
//     return postId.hashCode ^
//         postType.hashCode ^
//         privacyType.hashCode ^
//         creatorUserId.hashCode ^
//         creatorUserName.hashCode ^
//         creatorProfileId.hashCode ^
//         creatorFullName.hashCode ^
//         creatorAvatar.hashCode ^
//         caption.hashCode ^
//         description.hashCode ^
//         createdAt.hashCode ^
//         updatedAt.hashCode ^
//         medium.hashCode ^
//         likes.hashCode ^
//         unLikes.hashCode ^
//         comments.hashCode ^
//         shares.hashCode ^
//         views.hashCode ^
//         reports.hashCode ^
//         associates.hashCode ^
//         eventVenue.hashCode ^
//         eventLatitude.hashCode ^
//         eventLongitude.hashCode ^
//         eventDate.hashCode;
//   }
// }



