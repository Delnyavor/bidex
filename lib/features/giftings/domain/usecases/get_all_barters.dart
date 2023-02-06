import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/gift_item.dart';
import '../repositories/gift_repository.dart';

class GetAllGifts {
  final GiftRepository repository;

  GetAllGifts({required this.repository});

  Future<Either<Failure, List<Gift>?>?>? call([int index = 0]) async {
    return await repository.getAllGifts(index);
  }
}
