import 'package:bidex/features/auth/domain/entities/user.dart';
import 'package:bidex/features/auth/domain/entities/user_data.dart';
import 'package:bidex/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class CreateUser {
  final AuthRepository repository;

  CreateUser(this.repository);

  Future<Either<Failure, User?>?>? call(UserData user) async {
    return await repository.createUser(user);
  }
}
