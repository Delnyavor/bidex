import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/transaction.dart';

abstract class TransactionRepository {
  Future<Either<Failure, List<Transaction>?>>? getAllTransactions([int index]);
  Future<Either<Failure, Transaction?>>? getTransaction(
      Transaction auctionItem);
}
