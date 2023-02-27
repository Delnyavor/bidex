import 'package:bidex/features/auth/data/datasources/auth_data_source.dart';
import 'package:bidex/features/auth/data/datasources/firebase_auth_source.dart';
import 'package:bidex/features/auth/domain/entities/user.dart';
import 'package:bidex/features/auth/domain/entities/user_data.dart';
import 'package:bidex/core/error/failures.dart';
import 'package:bidex/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../../core/error/exceptions.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthDataSource authDataSource;
  final FirebaseAuthDataSource firebaseAuthDataSource;
  const AuthRepositoryImplementation({
    required this.authDataSource,
    required this.firebaseAuthDataSource,
  });

  @override
  Future<Either<Failure, User?>>? signIn(String email, String password) async {
    try {
      final authUser = await firebaseAuthDataSource.signIn(email, password);
      if (authUser != null) {
        final userResult = await authDataSource.getUser(authUser.uid);
        return Right(userResult);
      } else {
        return const Left(AuthFailure(message: 'An error occurred'));
      }
    } on Exception catch (e) {
      return Left(handleException(e));
    }
  }

  @override
  Future<Either<Failure, User?>>? createUser(UserData user) async {
    try {
      final authUser =
          await firebaseAuthDataSource.createUser(user.email, user.password);
      if (authUser != null) {
        final userResult = await authDataSource.createUser(user, authUser.uid);
        return Right(userResult);
      } else {
        return const Left(AuthFailure(message: ''));
      }
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
  Future<Either<Failure, User?>>? getUser(String id) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User?>>? updateUser(UserData user) {
    // TODO: implement updateUser
    throw UnimplementedError();
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

//TODO: test the error messages
Failure handleException(Exception e) {
  Failure result;
  switch (e.runtimeType) {
    case ServerException:
      {
        result = const ServerFailure(message: 'Could not reach servers');
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
