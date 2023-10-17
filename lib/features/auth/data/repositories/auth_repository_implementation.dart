import 'package:bidex/features/auth/data/datasources/auth_data_source.dart';
import 'package:bidex/features/auth/data/datasources/local_data_source.dart';
import 'package:bidex/features/auth/domain/entities/user.dart';
import 'package:bidex/core/error/failures.dart';
import 'package:bidex/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../../core/error/exceptions.dart';

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

      if (user == null) {
        
      }

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
  Future<Either<Failure, bool?>>? deleteUser(String id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User?>>? getUser(String id) async {
    return Right(await localAuthSource.getUser());
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

Failure handleException(Exception e) {
  Failure result;
  switch (e.runtimeType) {
    case ServerException:
      {
        result = ServerFailure(message: e.toString());
      }
      break;
    case CacheException:
      {
        result = CacheFailure(message: e.toString());
      }
      break;
    case auth.FirebaseAuthException:
      {
        result = ServerFailure(message: e.toString());
      }
      break;
    case FirebaseException:
      {
        result = ServerFailure(message: e.toString());
      }
      break;
    default:
      {
        result = const GenericOperationFailure(message: 'An error occurred');
      }
  }
  return result;
}
