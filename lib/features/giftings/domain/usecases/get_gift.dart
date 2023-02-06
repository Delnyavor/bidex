import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/gift_item.dart';
import '../repositories/gift_repository.dart';

class GetGift {
  final GiftRepository repository;

  GetGift({required this.repository});

  Future<Either<Failure, Gift?>?>? call({required int id}) async {
    return await repository.getGift(id);
  }
}
