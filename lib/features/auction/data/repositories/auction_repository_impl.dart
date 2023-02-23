import 'package:bidex/core/error/failures.dart';
import 'package:bidex/features/auction/data/datasources/auction_remote_data_source.dart';
import 'package:bidex/features/auction/domain/repositories/auction_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:bidex/features/auction/domain/entities/auction_item.dart';

import '../../../../core/error/exceptions.dart';

class AuctionRepositoryImpl extends AuctionRepository {
  final AuctionRemoteDataSource dataSource;

  AuctionRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, AuctionItem?>>? createAuctionItem(
      AuctionItem auctionItem) async {
    try {
      final result = await dataSource.createAuction(auctionItem);
      return Right(result);
    } on ServerException catch (_) {
      return const Left(ServerFailure(message: ''));
    } on CacheException catch (_) {
      return const Left(CacheFailure(message: ''));
    }
  }

  @override
  Future<Either<Failure, AuctionItem?>>? getAuctionItem(int id) async {
    try {
      final result = await dataSource.getAuction(id);
      return Right(result);
    } on ServerException catch (_) {
      return const Left(ServerFailure(message: ''));
    } on CacheException catch (_) {
      return const Left(CacheFailure(message: ''));
    }
  }

  @override
  Future<Either<Failure, List<AuctionItem>?>>? getAllAuctionItems(
      [int index = 0]) async {
    try {
      final result = await dataSource.getAllItems(index);
      return Right(result);
    } on ServerException catch (_) {
      return const Left(ServerFailure(message: 'Something went wrong'));
    } on CacheException catch (_) {
      return const Left(CacheFailure(message: ''));
    }
  }

  @override
  Future<Either<Failure, AuctionItem?>>? updateAuctionItem(
      AuctionItem auctionItem) async {
    try {
      final result = await dataSource.updateAuction(auctionItem);
      return Right(result);
    } on ServerException catch (_) {
      return const Left(ServerFailure(message: ''));
    } on CacheException catch (_) {
      return const Left(CacheFailure(message: ''));
    }
  }

  @override
  Future<Either<Failure, bool?>>? deleteAuctionItem(int id) async {
    try {
      final result = await dataSource.deleteAuction(id);
      return Right(result);
    } on ServerException catch (_) {
      return const Left(ServerFailure(message: ''));
    } on CacheException catch (_) {
      return const Left(CacheFailure(message: ''));
    }
  }
}
