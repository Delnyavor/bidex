import 'package:bidex/core/error/exception_handler.dart';
import 'package:bidex/features/auth/data/datasources/auth_data_source.dart';
import 'package:bidex/features/auth/data/datasources/local_data_source.dart';
import 'package:bidex/features/auth/domain/entities/user.dart';
import 'package:bidex/core/error/failures.dart';
import 'package:bidex/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthDataSource authDataSource;
  final LocalAuthSource localAuthSource;
  const AuthRepositoryImplementation({
    required this.authDataSource,
    required this.localAuthSource,
  });

  @override
  Future<Either<Failure, User?>>? signIn(String email, String password) async {
    try {
      final user = await authDataSource.signIn(email, password);

      if (user == null) {}

      localAuthSource.saveUser(user!);
      return Right(user);
    } on Exception catch (e) {
      return Left(handleException(e));
    }
  }

  @override
  Future<Either<Failure, User?>>? createUser(
      String email, String password) async {
    try {
      final user = await authDataSource.createUser(email, password);

      localAuthSource.saveUser(user);
      return Right(user);
    } on Exception catch (e) {
      return Left(handleException(e));
    }
  }

  @override
  Future<Either<Failure, bool?>>? logout(String id) async {
    try {
      await localAuthSource.logout();
      return const Right(true);
    } on Exception catch (e) {
      return Left(handleException(e));
    }
  }

  @override
  Future<Either<Failure, User?>>? getUser(String id) async {
    try {
      return Right(await localAuthSource.getUser());
    } on Exception catch (e) {
      return Left(handleException(e));
    }
  }

  @override
  Future<Either<Failure, User?>>? updateUser(User user) async {
    try {
      final userResult = await authDataSource.updateUser(user);
      if (userResult == null) {
        return const Left(AuthFailure(
            message: 'An error occurred while creating your account'));
      }
      return Right(user);
    } on Exception catch (e) {
      return Left(handleException(e));
    }
  }

  @override
  Future<Either<Failure, bool?>>? verify(String password) async {
    try {
      final bool? result = await authDataSource.verify(password);
      if (result != null) {
        return Right(result);
      } else {
        return const Left(AuthFailure(message: ''));
      }
    } on Exception catch (e) {
      return Left(handleException(e));
    }
  }
}
