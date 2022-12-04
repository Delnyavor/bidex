import 'package:bidex/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class DeleteUser {
  final AuthRepository repository;

  DeleteUser(this.repository);

  Future<Either<Failure, bool?>?>? call(String id) async {
    return await repository.deleteUser(id);
  }
}
