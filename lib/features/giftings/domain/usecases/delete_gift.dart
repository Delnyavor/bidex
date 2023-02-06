import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/gift_repository.dart';

class DeleteGift {
  final GiftRepository repository;

  DeleteGift({required this.repository});

  Future<Either<Failure, bool?>?>? call({required int id}) async {
    return await repository.deleteGift(id);
  }
}
