class Comment {
  final String? id;
  final String userId;
  final String? postId;
  final String? reviewId;
  final String text;
  final List<Media> media;
  final List<Reply> replies;
  final List<String> likes;
  final List<String> unLikes;
  final List<String> reports;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Comment({
    this.id,
    required this.userId,
    this.postId,
    this.reviewId,
    required this.text,
    this.media = const [],
    this.replies = const [],
    this.likes = const [],
    this.unLikes = const [],
    this.reports = const [],
    this.createdAt,
    this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'] as String?,
      userId: json['user'] as String,
      postId: json['post'] as String?,
      reviewId: json['review'] as String?,
      text: json['text'] as String,
      media: (json['media'] as List<dynamic>?)
              ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      replies: (json['replies'] as List<dynamic>?)
              ?.map((e) => Reply.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      likes: List<String>.from(json['likes'] ?? []),
      unLikes: List<String>.from(json['unLikes'] ?? []),
      reports: List<String>.from(json['reports'] ?? []),
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': userId,
      'post': postId,
      'review': reviewId,
      'text': text,
      'media': media.map((e) => e.toJson()).toList(),
      'replies': replies.map((e) => e.toJson()).toList(),
      'likes': likes,
      'unLikes': unLikes,
      'reports': reports,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class Media {
  final String type;
  final String url;

  Media({
    required this.type,
    required this.url,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      type: json['type'] as String,
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'url': url,
    };
  }
}

class Reply {
  final String userId;
  final String text;
  final List<String> likes;
  final List<String> unLikes;
  final List<String> reports;
  final DateTime createdAt;

  Reply({
    required this.userId,
    required this.text,
    this.likes = const [],
    this.unLikes = const [],
    this.reports = const [],
    required this.createdAt,
  });

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      userId: json['user'] as String,
      text: json['text'] as String,
      likes: List<String>.from(json['likes'] ?? []),
      unLikes: List<String>.from(json['unLikes'] ?? []),
      reports: List<String>.from(json['reports'] ?? []),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': userId,
      'text': text,
      'likes': likes,
      'unLikes': unLikes,
      'reports': reports,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
