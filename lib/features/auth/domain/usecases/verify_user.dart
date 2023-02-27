import 'package:bidex/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class Verify {
  final AuthRepository repository;

  Verify(this.repository);

  Future<Either<Failure, bool?>?>? call(String password) async {
    return await repository.verify(password);
  }
}
