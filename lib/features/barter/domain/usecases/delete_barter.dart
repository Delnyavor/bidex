import 'package:bidex/features/barter/domain/repositories/barter_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class DeleteBarter {
  final BarterRepository repository;

  DeleteBarter({required this.repository});

  Future<Either<Failure, bool?>?>? call({required int id}) async {
    return await repository.deleteBarterItem(id);
  }
}
