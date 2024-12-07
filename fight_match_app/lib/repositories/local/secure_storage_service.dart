import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Save user credentials to secure storage
  Future<void> saveUserCredentials(
    String email,
    String password,
    String userId,
    // String profileId,
    String jwt,
    String rwt,
  ) async {
    await _storage.write(key: 'email', value: email);
    await _storage.write(key: 'password', value: password);
    await _storage.write(key: 'userId', value: userId);
    // await _storage.write(key: 'profileId', value: profileId);
    await _storage.write(key: 'jwt', value: jwt);
    await _storage.write(key: 'rwt', value: rwt);
  }

  // Load user credentials from secure storage
  Future<Map<String, String?>> loadUserCredentials() async {
    final email = await _storage.read(key: 'email');
    final password = await _storage.read(key: 'password');
    final userId = await _storage.read(key: 'userId');
    // final profileId = await _storage.read(key: 'profileId');
    final jwt = await _storage.read(key: 'jwt');
    final rwt = await _storage.read(key: 'rwt');

    return {
      'email': email,
      'password': password,
      'userId': userId,
      // 'profileId': profileId,
      'jwt': jwt,
      'rwt': rwt,
    };
  }

  // Clear user credentials from secure storage
  Future<void> clearUserCredentials() async {
    await _storage.delete(key: 'email');
    await _storage.delete(key: 'password');
    await _storage.delete(key: 'userId');
    await _storage.delete(key: 'profileId');
    await _storage.delete(key: 'jwt');
    await _storage.delete(key: 'rwt');
  }
}
