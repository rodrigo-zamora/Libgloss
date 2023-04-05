import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class UserAuthRepository {
  Future<void> isAuthenticated() async {}

  String? getuid() {
    return null;
  }

  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<void> signIn() async {}

  Future<bool> signInWithGoogle() async {
    try {
      final result =
          await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
      print('Resultfor the login: ${result.nextStep?.additionalInfo}');
      return result.isSignedIn;
    } on AuthException catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
  }

  Future<bool> signInWithFacebook() async {
    try {
      final result =
          await Amplify.Auth.signInWithWebUI(provider: AuthProvider.facebook);
      print('Result for the login: ${result.nextStep?.additionalInfo}');
      return result.isSignedIn;
    } on AuthException catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
  }
}
