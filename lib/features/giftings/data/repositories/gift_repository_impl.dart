import 'package:bidex/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/gift_item.dart';
import '../../domain/repositories/gift_repository.dart';
import '../datasources/gift_remote_data_source.dart';

class GiftRepositoryImpl extends GiftRepository {
  final GiftRemoteDataSource dataSource;

  GiftRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Gift?>>? createGift(Gift gift) async {
    try {
      final result = await dataSource.createGift(gift);
      return Right(result);
    } on ServerException catch (_) {
      return const Left(ServerFailure(message: ''));
    } on CacheException catch (_) {
      return const Left(CacheFailure(message: ''));
    }
  }

  @override
  Future<Either<Failure, Gift?>>? getGift(int id) async {
    try {
      final result = await dataSource.getGift(id);
      return Right(result);
    } on ServerException catch (_) {
      return const Left(ServerFailure(message: ''));
    } on CacheException catch (_) {
      return const Left(CacheFailure(message: ''));
    }
  }

  @override
  Future<Either<Failure, List<Gift>?>>? getAllGifts([int index = 0]) async {
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
  Future<Either<Failure, Gift?>>? updateGift(Gift gift) async {
    try {
      final result = await dataSource.updateGift(gift);
      return Right(result);
    } on ServerException catch (_) {
      return const Left(ServerFailure(message: ''));
    } on CacheException catch (_) {
      return const Left(CacheFailure(message: ''));
    }
  }

  @override
  Future<Either<Failure, bool?>>? deleteGift(int id) async {
    try {
      final result = await dataSource.deleteGift(id);
      return Right(result);
    } on ServerException catch (_) {
      return const Left(ServerFailure(message: ''));
    } on CacheException catch (_) {
      return const Left(CacheFailure(message: ''));
    }
  }
}
