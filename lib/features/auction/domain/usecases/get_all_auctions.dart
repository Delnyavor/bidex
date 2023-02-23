import 'package:bidex/features/auction/domain/entities/auction_item.dart';
import 'package:bidex/features/auction/domain/repositories/auction_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class GetAllAuctions {
  final AuctionRepository repository;

  GetAllAuctions({required this.repository});

  Future<Either<Failure, List<AuctionItem>?>?>? call([int index = 0]) async {
    return await repository.getAllAuctionItems(index);
  }
}
