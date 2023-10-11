import 'package:bidex/features/auth/domain/entities/user.dart';
import 'package:bidex/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class CreateUser {
  final AuthRepository repository;

  CreateUser(this.repository);

  Future<Either<Failure, User?>?>? call(String email, String password) async {
    return await repository.createUser(email, password);
  }
}
