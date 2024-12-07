import 'user.dart';

class Auth {
  final String userId;
  final String userName;
  final String email;
  final String jwt;
  final String rwt;
  final User profile;

  Auth({
    required this.userId,
    required this.userName,
    required this.email,
    required this.jwt,
    required this.rwt,
    required this.profile,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      userId: json['user']['_id'],
      userName: json['user']['userName'],
      email: json['user']['email'],
      jwt: json['jwt'],
      rwt: json['rwt'],
      profile: User.fromJson(json['profile']),
    );
  }

  @override
  String toString() {
    return 'Auth(userId: $userId, userName: $userName, email: $email, jwt: $jwt, rwt: $rwt, profile: $profile)';
  }
}
