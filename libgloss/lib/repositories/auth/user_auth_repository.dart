import 'dart:convert';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import '../../models/Users.dart';
import '../../models/user.dart';

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
      print('Result for the login: ${result.nextStep?.additionalInfo}');
      final user = await Amplify.Auth.getCurrentUser();
      final detailsUser = await Amplify.Auth.fetchUserAttributes();
      var detailsId = jsonDecode(detailsUser[1].value);
      final post = await Amplify.DataStore.save(new Users(
          id: detailsId[0]['userId'],
          email: detailsUser[3].value,
          createdDate: TemporalDateTime(new DateTime.fromMillisecondsSinceEpoch(
              detailsId[0]['dateCreated'])),
          updatedDate: TemporalDateTime(new DateTime.fromMillisecondsSinceEpoch(
              detailsId[0]['dateCreated'])),
          phoneNumber: '666-666-666-666',
          profilePicture:
              'https://i.pinimg.com/564x/d4/37/4b/d4374b6dc2934880eaa7a5e8989c1f64.jpg',
          token: result.nextStep!.additionalInfo!['token'],
          username: detailsUser[3].value,
          zipCode: '4503747',
          isAdministrator: false));
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
      dynamic details = await Amplify.Auth.fetchUserAttributes();
      return result.isSignedIn;
    } on AuthException catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
  }
}
