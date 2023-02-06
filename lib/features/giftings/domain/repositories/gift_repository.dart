import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/gift_item.dart';

abstract class GiftRepository {
  Future<Either<Failure, List<Gift>?>>? getAllGifts([int index]);
  Future<Either<Failure, Gift?>>? createGift(Gift gift);
  Future<Either<Failure, Gift?>>? getGift(int id);
  Future<Either<Failure, Gift?>>? updateGift(Gift gift);
  Future<Either<Failure, bool?>>? deleteGift(int id);
}
