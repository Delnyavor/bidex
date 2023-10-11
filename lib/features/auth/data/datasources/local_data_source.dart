import 'package:bidex/features/auth/domain/entities/user.dart';

abstract class LocalAuthSource {
  ///Queries for the current login status
  ///
  ///Throws a [CacheException] for all error codes
  Future<bool> isloggedIn();

  ///Queries for the currently logged in user
  ///
  ///Throws a [CacheException] for all error codes
  Future<dynamic> getUser();

  ///
  ///Throws a [CacheException] for all error codes
  Future<void> saveUser(User user);

  ///
  ///Throws a [CacheException] for all error codes
  Future<void> deleteUser();
}
