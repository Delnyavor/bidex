import 'package:bidex/features/auth/domain/entities/user.dart';
import 'package:bidex/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class GetUser {
  final AuthRepository repository;

  GetUser(this.repository);

  Future<Either<Failure, User?>?>? call(String id) async {
    return await repository.getUser(id);
  }
}
