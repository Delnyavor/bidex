import 'package:bidex/features/auth/domain/entities/user.dart';
import 'package:bidex/features/auth/domain/entities/user_data.dart';

abstract class AuthDataSource {
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
  Future<User?> createUser(UserData data, String uid);

  ///Calls the [EndPoint endpoint]
  ///
  ///Throws a [ServerException] for all error codes
  Future<dynamic> updateUser();

  ///Calls the [EndPoint endpoint]
  ///
  ///Throws a [ServerException] for all error codes
  Future<dynamic> modifyUser();

  ///Calls the [EndPoint endpoint]
  ///
  ///Throws a [ServerException] for all error codes
  Future<dynamic> deleteUser();

  ///Calls the [Auction endpoint]
  ///
  ///Throws a [ServerException] for all error codes
  Future<bool?> verify(String password);
}
