import 'package:bidex/core/error/failures.dart';
import 'package:dartz/dartz.dart' as dartz;

import '../entities/user.dart';

abstract class AuthRepository {
  Future<dartz.Either<Failure, User?>>? createUser(
      String email, String password);
  Future<dartz.Either<Failure, User?>>? getUser(String id);
  Future<dartz.Either<Failure, User?>>? updateUser(User user);
  Future<dartz.Either<Failure, bool?>>? deleteUser(String id);
  Future<dartz.Either<Failure, User?>>? signIn(String email, String password);
  Future<dartz.Either<Failure, bool?>>? verify(String password);
}
