String generateUsername(String email) {
  final username = email.split('@')[0];
  return username;
}
