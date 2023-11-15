import 'package:bidex/core/error/exception_handler.dart';
import 'package:bidex/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/gift_item.dart';
import '../../domain/repositories/gift_repository.dart';
import '../datasources/gift_remote_data_source.dart';

class GiftRepositoryImpl extends GiftRepository {
  final GiftRemoteDataSource dataSource;

  GiftRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Gift?>>? createGift(
      Gift gift, String authToken, String refreshToken) async {
    try {
      final result = await dataSource.createGift(gift, authToken, refreshToken);
      return Right(result);
    } on Exception catch (e) {
      return Left(handleException(e));
    }
  }

  @override
  Future<Either<Failure, Gift?>>? getGift(int id) async {
    try {
      final result = await dataSource.getGift(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(handleException(e));
    }
  }

  @override
  Future<Either<Failure, List<Gift>?>>? getAllGifts([int index = 0]) async {
    try {
      final result = await dataSource.getAllItems(index);
      return Right(result);
    } on Exception catch (e) {
      return Left(handleException(e));
    }
  }

  @override
  Future<Either<Failure, Gift?>>? updateGift(Gift gift) async {
    try {
      final result = await dataSource.updateGift(gift);
      return Right(result);
    } on Exception catch (e) {
      return Left(handleException(e));
    }
  }

  @override
  Future<Either<Failure, bool?>>? deleteGift(int id) async {
    try {
      final result = await dataSource.deleteGift(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(handleException(e));
    }
  }
}
