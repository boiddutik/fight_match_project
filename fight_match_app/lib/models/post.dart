class Post {
  final String user;
  final String privacy;
  final String title;
  final String description;
  final List<String> images;
  final List<String> videos;
  final List<String> comments;
  final List<String> likes;
  final List<String> unLikes;
  final List<String> shares;
  final List<String> views;
  final List<String> reports;
  final String id;
  final String createdAt;
  final String updatedAt;

  Post({
    required this.user,
    required this.privacy,
    required this.title,
    required this.description,
    required this.images,
    required this.videos,
    required this.comments,
    required this.likes,
    required this.unLikes,
    required this.shares,
    required this.views,
    required this.reports,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      user: json['user'],
      privacy: json['privacy'],
      title: json['title'],
      description: json['description'],
      images: List<String>.from(json['images']),
      videos: List<String>.from(json['videos']),
      comments: List<String>.from(json['comments']),
      likes: List<String>.from(json['likes']),
      unLikes: List<String>.from(json['unLikes']),
      shares: List<String>.from(json['shares']),
      views: List<String>.from(json['views']),
      reports: List<String>.from(json['reports']),
      id: json['_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'privacy': privacy,
      'title': title,
      'description': description,
      'images': images,
      'videos': videos,
      'comments': comments,
      'likes': likes,
      'unLikes': unLikes,
      'shares': shares,
      'views': views,
      'reports': reports,
      '_id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
