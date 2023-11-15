import 'package:bidex/features/auction/domain/repositories/auction_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/auction_item.dart';

class CreateAuction {
  final AuctionRepository repository;

  CreateAuction({required this.repository});

  Future<Either<Failure, AuctionItem?>?>? call(
      {required AuctionItem auctionItem,
      required String authToken,
      required String refreshToken}) async {
    return await repository.createAuctionItem(
        auctionItem, authToken, refreshToken);
  }
}
