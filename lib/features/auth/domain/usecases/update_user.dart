import 'package:bidex/features/auth/domain/entities/user.dart';
import 'package:bidex/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class UpdateUser {
  final AuthRepository repository;

  UpdateUser(this.repository);

  Future<Either<Failure, User?>?>? call(User user) async {
    return await repository.updateUser(user);
  }
}
