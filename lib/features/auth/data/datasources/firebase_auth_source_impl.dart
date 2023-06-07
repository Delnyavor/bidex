import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'firebase_auth_source.dart';

class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthDataSourceImpl({required this.firebaseAuth});

  @override
  Future<User?> createUser(String email, String password) async {
    UserCredential credential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    return credential.user;
  }

  @override
  Future<User?> getUser() async {
    return firebaseAuth.currentUser;
  }

  @override
  Future<User?> signIn(String email, String password) async {
    UserCredential credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    if (kDebugMode) {
      print('Cred: $credential');
    }
    return credential.user;
  }
}
