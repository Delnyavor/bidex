import 'package:bidex/features/giftings/domain/repositories/gift_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/gift_item.dart';

class CreateGift {
  final GiftRepository repository;

  CreateGift({required this.repository});

  Future<Either<Failure, Gift?>?>? call(
      {required Gift gift,
      required String authToken,
      required String refreshToken}) async {
    return await repository.createGift(gift, authToken, refreshToken);
  }
}
