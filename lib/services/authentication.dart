import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_tracker/database/SharePrefs.dart';

class Authentication {
  FirebaseAuth auth;

  Authentication() {
    auth = FirebaseAuth.instance;
  }

  Future<User> anonymousSignIn() async {
    UserCredential userCredential = await auth.signInAnonymously();

    User user = userCredential.user;

    SharePrefs.idToken = await user.getIdToken();
    SharePrefs.loggedInUserId = user.uid;

    return user;
  }

  Future<bool> signOutUser() async {

    await auth.signOut();

    return Future.value(true);
  }
}

