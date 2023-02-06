import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/gift_item.dart';
import '../repositories/gift_repository.dart';

class UpdateGift {
  final GiftRepository repository;

  UpdateGift({required this.repository});

  Future<Either<Failure, Gift?>?>? call({required Gift gift}) async {
    return await repository.updateGift(gift);
  }
}
