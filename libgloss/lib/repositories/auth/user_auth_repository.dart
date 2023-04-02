import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class UserAuthRepository {
  bool isAuthenticated() {
    return false;
  }

  String? getuid() {
    return null;
  }

  Future<void> signOut() async {}

  Future<void> signIn() async {}

  Future<void> signInWithGoogle() async {
    try {
      final result =
          await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
      print('Resultfor the login: $result');
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      final result =
          await Amplify.Auth.signInWithWebUI(provider: AuthProvider.facebook);
      print('Resultfor the login: $result');
    } on AuthException catch (e) {
      print(e.message);
    }
  }
  // TODO: Implement user auth using Amplify Auth
}
