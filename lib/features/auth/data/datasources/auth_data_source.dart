import 'package:bidex/features/auth/domain/entities/user.dart';

abstract class AuthDataSource {
  Future<dynamic> signIn(String email, String password);

  ///Queries the Users list for a user
  ///
  ///Throws a [ServerException] for all error codes
  Future<dynamic> getUser(String id);

  ///Calls the [EndPoint endpoint]
  ///
  ///Throws a [ServerException] for all error codes
  Future<dynamic> getAllUsers();

  ///Calls the [EndPoint endpoint]
  ///
  ///Throws a [ServerException] for all error codes
  Future<dynamic> createUser(String email, String password);

  ///Calls the [EndPoint endpoint]
  ///
  ///Throws a [ServerException] for all error codes
  Future<User?> updateUser(User user);

  ///Calls the [EndPoint endpoint]
  ///
  ///Throws a [ServerException] for all error codes
  Future<dynamic> deleteUser();

  ///Calls the [Auction endpoint]
  ///
  ///Throws a [ServerException] for all error codes
  Future<bool?> verify(String password);
}
