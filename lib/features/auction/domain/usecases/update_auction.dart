import 'package:bidex/features/auction/domain/repositories/auction_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/auction_item.dart';

class UpdateAuction {
  final AuctionRepository repository;

  UpdateAuction({required this.repository});

  Future<Either<Failure, AuctionItem?>?>? call(
      {required AuctionItem auctionItem}) async {
    return await repository.updateAuctionItem(auctionItem);
  }
}
