import 'package:bidex/features/auction/domain/repositories/auction_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/auction_item.dart';

class GetAuction {
  final AuctionRepository repository;

  GetAuction({required this.repository});

  Future<Either<Failure, AuctionItem?>?>? call({required int id}) async {
    return await repository.getAuctionItem(id);
  }
}
