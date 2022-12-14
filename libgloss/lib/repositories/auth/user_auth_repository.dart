import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static FirebaseAuth? userInstance = null;

  UserAuthRepository() {
    userInstance = _auth;
  }

  FirebaseAuth getInstance() {
    return _auth;
  }

  bool isAuthenticated() {
    return _auth.currentUser != null;
  }

  String? getuid() {
    print('\x1B[32mcurrent user: ${_auth.currentUser}');
    return _auth.currentUser?.uid;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<void> signIn() async {}

  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final authResult = await _auth.signInWithCredential(credential);

      final user = authResult.user;

      if (user != null) {
        final User? currentUser = _auth.currentUser;
        assert(user.uid == currentUser!.uid);

        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection('users')
            .where('id', isEqualTo: user.uid)
            .get();

        final List<DocumentSnapshot> documents = result.docs;

        if (documents.length == 0) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'id': user.uid,
            'username': user.displayName,
            'profilePicture': user.photoURL,
            'email': user.email,
            'phoneNumber': user.phoneNumber,
            'zipCode': null,
            'isSeller': false,
            'isAdministrator': false,
            'notifications': true,
          });

          await FirebaseFirestore.instance.collection('lists').add({
            'useruid': user.uid,
            'tracking': [],
            'wish': [],
          });

          var myToken = await FirebaseMessaging.instance.getToken();
          FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({'token': myToken});
        }
      } else {
        throw Exception('Error signing in with Google: $user');
      }
    } catch (e) {
      print(e);
      throw Exception('Error signing in with Google: $e');
    }
  }
}
