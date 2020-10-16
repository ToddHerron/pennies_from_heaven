import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';

@immutable
class User {
  const User({@required this.uid});
  final String uid;
}

class FirebaseAuthService {
  final _firebaseAuth = auth.FirebaseAuth.instance;
  // final _firebaseAuth = auth.FirebaseAuth.instanceFor();
  // final _firebaseAuth = auth.FirebaseAuth.instance.currentUser;

  User _userFromFirebase(auth.User user) {
    return user == null ? null : User(uid: user.uid);
  }

  Stream<User> get authStateChanges {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
