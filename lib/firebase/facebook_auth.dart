import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:primer_proyecto/models/user_model.dart';

class FacebookAuthentication {
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserModel> signInWithFacebook() async {
    this.signOut();
    try {
      final LoginResult result = await _facebookAuth.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);
        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        print('User login: ${userCredential.user}');
        UserModel user = UserModel.fromFirebaseUser(userCredential.user!);
        return user;
      } else {
        return UserModel(name: null);
      }
    } catch (e) {
      print('Error signing in with Facebook: $e');
      return UserModel(name: null);
    }
  }

  Future<bool> signUpWithFacebook() async {
    this.signOut();
    try {
      final LoginResult result = await _facebookAuth.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);

        // Creating a Firebase user with email and password
        final UserCredential userCredential =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: accessToken.userId +
              '@facebook.com', // Using the Facebook user ID as email
          password:
              accessToken.token, // Using the Facebook access token as password
        );
        // Linking the Facebook credential to the Firebase user
        await userCredential.user!.linkWithCredential(credential);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error signing up with Facebook: $e');
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await _facebookAuth.logOut();
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}
