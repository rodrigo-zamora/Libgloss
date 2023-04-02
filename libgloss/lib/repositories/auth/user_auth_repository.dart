class UserAuthRepository {
  bool isAuthenticated() {
    return false;
  }

  String? getuid() {
    return null;
  }

  Future<void> signOut() async {}

  Future<void> signIn() async {}

  // TODO: Implement user auth using Amplify Auth
}
