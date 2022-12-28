import 'package:bidex/features/barter/domain/repositories/barter_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/barter_item.dart';

class GetAllBarters {
  final BarterRepository repository;

  GetAllBarters({required this.repository});

  Future<Either<Failure, List<BarterItem>?>?>? call() async {
    return await repository.getAllBarterItems();
  }
}
