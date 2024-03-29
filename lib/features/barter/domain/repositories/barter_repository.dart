import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/barter_item.dart';

abstract class BarterRepository {
  Future<Either<Failure, List<BarterItem>?>>? getAllBarterItems([int index]);
  Future<Either<Failure, BarterItem?>>? createBarterItem(
      BarterItem barterItem, String authToken, String refreshToken);
  Future<Either<Failure, BarterItem?>>? getBarterItem(int id);
  Future<Either<Failure, BarterItem?>>? updateBarterItem(BarterItem barterItem);
  Future<Either<Failure, bool?>>? deleteBarterItem(int id);
}
