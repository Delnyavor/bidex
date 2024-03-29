import 'package:bidex/features/barter/domain/repositories/barter_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/barter_item.dart';

class CreateBarter {
  final BarterRepository repository;

  CreateBarter({required this.repository});

  Future<Either<Failure, BarterItem?>?>? call(
      {required BarterItem barterItem,
      required String authToken,
      required String refreshToken}) async {
    return await repository.createBarterItem(
        barterItem, authToken, refreshToken);
  }
}
