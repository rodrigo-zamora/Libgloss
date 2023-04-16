import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
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

  Future<Users?> signInWithGoogle() async {
    try {
      final result =
          await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
      print('Result for the login: ${result.nextStep?.additionalInfo}');
      final detailsUser = await Amplify.Auth.fetchUserAttributes();
      final query = Users.EMAIL.eq(detailsUser[3].value);
      final req = ModelQueries.list<Users>(Users.classType, where: query);
      final res = await Amplify.API.query(request: req).response;
      print('Posts: ${res.data?.items.first}');
      if (res.data != null) {
        return res.data?.items.first;
      }

      var detailsId = jsonDecode(detailsUser[1].value);
      final newUser = new Users(
          sellerID: "",
          settingsID: "",
          email: detailsUser[3].value,
          createdDate: TemporalDateTime(new DateTime.fromMillisecondsSinceEpoch(
              detailsId[0]['dateCreated'])),
          updatedDate: TemporalDateTime(new DateTime.fromMillisecondsSinceEpoch(
              detailsId[0]['dateCreated'])),
          phoneNumber: "+52 33 1387 7570",
          profilePicture:
              'https://i.pinimg.com/564x/d4/37/4b/d4374b6dc2934880eaa7a5e8989c1f64.jpg',
          token: result.nextStep!.additionalInfo!['token'],
          username: detailsUser[3].value,
          zipCode: '4503747',
          isAdministrator: false);
      final request = ModelMutations.create(newUser);
      final response = await Amplify.API.mutate(request: request).response;

      final createdUser = response.data;
      if (createdUser == null) {
        safePrint('errors: ${response.errors}');
        return null;
      }
      safePrint('Mutation result: ${createdUser.email}');
      return response.data!;
    } on AuthException catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
  }

  Future<Users?> signInWithFacebook() async {
    try {
      final result =
          await Amplify.Auth.signInWithWebUI(provider: AuthProvider.facebook);
      print('Result for the login: ${result.nextStep?.additionalInfo}');
      final detailsUser = await Amplify.Auth.fetchUserAttributes();
      final query = Users.EMAIL.eq(detailsUser[3].value);
      final req = ModelQueries.list<Users>(Users.classType, where: query);
      final res = await Amplify.API.query(request: req).response;
      print('Posts: ${res.data?.items}');
      if (res.data!.items.length > 0) {
        return res.data!.items.first!;
      }

      var detailsId = jsonDecode(detailsUser[1].value);
      final newUser = new Users(
          sellerID: " ",
          settingsID: " ",
          email: detailsUser[3].value,
          createdDate: TemporalDateTime(new DateTime.fromMillisecondsSinceEpoch(
              detailsId[0]['dateCreated'])),
          updatedDate: TemporalDateTime(new DateTime.fromMillisecondsSinceEpoch(
              detailsId[0]['dateCreated'])),
          phoneNumber: "+52 33 1387 7570",
          profilePicture:
              'https://i.pinimg.com/564x/d4/37/4b/d4374b6dc2934880eaa7a5e8989c1f64.jpg',
          token: result.nextStep!.additionalInfo!['token'],
          username: detailsUser[3].value,
          zipCode: '4503747',
          isAdministrator: false);
      final request = ModelMutations.create(newUser);
      final response = await Amplify.API.mutate(request: request).response;

      final createdUser = response.data;
      if (createdUser == null) {
        safePrint('errors: ${response.errors}');
        return null;
      }
      safePrint('Mutation result: ${createdUser.email}');
      return response.data!;
    } on AuthException catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
  }
}
