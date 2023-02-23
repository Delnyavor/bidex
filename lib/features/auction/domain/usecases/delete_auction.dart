import 'package:bidex/features/auction/domain/repositories/auction_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class DeleteAuction {
  final AuctionRepository repository;

  DeleteAuction({required this.repository});

  Future<Either<Failure, bool?>?>? call({required int id}) async {
    return await repository.deleteAuctionItem(id);
  }
}
