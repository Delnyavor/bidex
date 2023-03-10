import 'package:bidex/features/barter/domain/repositories/barter_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/barter_item.dart';

class UpdateBarter {
  final BarterRepository repository;

  UpdateBarter({required this.repository});

  Future<Either<Failure, BarterItem?>?>? call(
      {required BarterItem barterItem}) async {
    return await repository.updateBarterItem(barterItem);
  }
}
