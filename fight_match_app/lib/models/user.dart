class User {
  String id;
  String userName;
  String email;
  String fullName;
  String gender;
  DateTime dob;
  String country;
  String state;
  String city;
  String profession;
  String bio;
  String avatar;
  String cover;
  List<String> conversations;
  List<String> posts;
  List<String> pinnedPosts;
  List<String> likedPosts;
  List<String> unLikedPosts;
  List<String> commentedPosts;
  List<String> sharedPosts;
  List<String> sentFollowRequests;
  List<String> receivedFollowRequests;
  List<String> followers;
  List<String> following;
  List<String> blockList;
  bool isOnline;
  bool lastOnlineAtVisible;
  int activityCount;
  bool isPrivateProfile;
  bool isProfileMatchable;
  List<String> wallets;
  List<String> sponsors;
  List<String> fights;
  List<String> achievements;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.userName,
    required this.email,
    required this.fullName,
    required this.gender,
    required this.dob,
    required this.country,
    required this.state,
    required this.city,
    required this.profession,
    required this.bio,
    required this.avatar,
    required this.cover,
    required this.conversations,
    required this.posts,
    required this.pinnedPosts,
    required this.likedPosts,
    required this.unLikedPosts,
    required this.commentedPosts,
    required this.sharedPosts,
    required this.sentFollowRequests,
    required this.receivedFollowRequests,
    required this.followers,
    required this.following,
    required this.blockList,
    required this.isOnline,
    required this.lastOnlineAtVisible,
    required this.activityCount,
    required this.isPrivateProfile,
    required this.isProfileMatchable,
    required this.wallets,
    required this.sponsors,
    required this.fights,
    required this.achievements,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a User object from a Map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      userName: json['userName'],
      email: json['email'],
      fullName: json['fullName'],
      gender: json['gender'],
      dob: DateTime.parse(json['dob']),
      country: json['country'],
      state: json['state'],
      city: json['city'],
      profession: json['profession'],
      bio: json['bio'] ?? '',
      avatar: json['avatar'],
      cover: json['cover'],
      conversations: List<String>.from(json['conversations']),
      posts: List<String>.from(json['posts']),
      pinnedPosts: List<String>.from(json['pinnedPosts']),
      likedPosts: List<String>.from(json['likedPosts']),
      unLikedPosts: List<String>.from(json['unLikedPosts']),
      commentedPosts: List<String>.from(json['commentedPosts']),
      sharedPosts: List<String>.from(json['sharedPosts']),
      sentFollowRequests: List<String>.from(json['sentFollowRequests']),
      receivedFollowRequests: List<String>.from(json['recievedFollowRequests']),
      followers: List<String>.from(json['followers']),
      following: List<String>.from(json['followerings']),
      blockList: List<String>.from(json['blockList']),
      isOnline: json['isOnline'],
      lastOnlineAtVisible: json['lastOnlineAtVisible'],
      activityCount: json['activityCount'],
      isPrivateProfile: json['isPrivateProfile'],
      isProfileMatchable: json['isProfileMatchable'],
      wallets: List<String>.from(json['wallets']),
      sponsors: List<String>.from(json['sponsors']),
      fights: List<String>.from(json['fights']),
      achievements: List<String>.from(json['achievements']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Method to convert the User object into a Map for easy JSON serialization
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userName': userName,
      'email': email,
      'fullName': fullName,
      'gender': gender,
      'dob': dob.toIso8601String(),
      'country': country,
      'state': state,
      'city': city,
      'profession': profession,
      'bio': bio,
      'avatar': avatar,
      'cover': cover,
      'conversations': conversations,
      'posts': posts,
      'pinnedPosts': pinnedPosts,
      'likedPosts': likedPosts,
      'unLikedPosts': unLikedPosts,
      'commentedPosts': commentedPosts,
      'sharedPosts': sharedPosts,
      'sentFollowRequests': sentFollowRequests,
      'recievedFollowRequests': receivedFollowRequests,
      'followers': followers,
      'followerings': following,
      'blockList': blockList,
      'isOnline': isOnline,
      'lastOnlineAtVisible': lastOnlineAtVisible,
      'activityCount': activityCount,
      'isPrivateProfile': isPrivateProfile,
      'isProfileMatchable': isProfileMatchable,
      'wallets': wallets,
      'sponsors': sponsors,
      'fights': fights,
      'achievements': achievements,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'User(id: $id, userName: $userName, email: $email, fullName: $fullName, gender: $gender, dob: $dob, country: $country, state: $state, city: $city, profession: $profession, bio: $bio, avatar: $avatar, cover: $cover, conversations: $conversations, posts: $posts, pinnedPosts: $pinnedPosts, likedPosts: $likedPosts, unLikedPosts: $unLikedPosts, commentedPosts: $commentedPosts, sharedPosts: $sharedPosts, sentFollowRequests: $sentFollowRequests, receivedFollowRequests: $receivedFollowRequests, followers: $followers, following: $following, blockList: $blockList, isOnline: $isOnline, lastOnlineAtVisible: $lastOnlineAtVisible, activityCount: $activityCount, isPrivateProfile: $isPrivateProfile, isProfileMatchable: $isProfileMatchable, wallets: $wallets, sponsors: $sponsors, fights: $fights, achievements: $achievements, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
