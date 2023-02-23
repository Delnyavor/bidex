import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/auction_item.dart';

abstract class AuctionRepository {
  Future<Either<Failure, List<AuctionItem>?>>? getAllAuctionItems([int index]);
  Future<Either<Failure, AuctionItem?>>? createAuctionItem(
      AuctionItem auctionItem);
  Future<Either<Failure, AuctionItem?>>? getAuctionItem(int id);
  Future<Either<Failure, AuctionItem?>>? updateAuctionItem(
      AuctionItem auctionItem);
  Future<Either<Failure, bool?>>? deleteAuctionItem(int id);
}
