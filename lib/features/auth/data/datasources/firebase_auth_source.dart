import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthDataSource {
  ///Queries the Users list for a user
  ///
  ///Throws a [ServerException] for all error codes
  Future<User?> getUser();

  ///Calls the [EndPoint endpoint]
  ///
  ///Throws a [ServerException] for all error codes
  Future<User?> createUser(String email, String password);

  ///Calls the [EndPoint endpoint]
  ///
  ///Throws a [ServerException] for all error codes
  Future<User?> signIn(String email, String password);
}
