import 'package:bidex/features/barter/domain/repositories/barter_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/barter_item.dart';

class GetBarter {
  final BarterRepository repository;

  GetBarter({required this.repository});

  Future<Either<Failure, BarterItem?>?>? call({required int id}) async {
    return await repository.getBarterItem(id);
  }
}
