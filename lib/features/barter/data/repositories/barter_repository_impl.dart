import 'package:bidex/core/error/failures.dart';
import 'package:bidex/features/barter/data/datasources/barter_remote_data_source.dart';
import 'package:bidex/features/barter/domain/repositories/barter_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:bidex/features/barter/domain/entities/barter_item.dart';

import '../../../../core/error/exceptions.dart';

class BarterRepositoryImpl extends BarterRepository {
  final BarterRemoteDataSource dataSource;

  BarterRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, BarterItem?>>? createBarterItem(
      BarterItem barterItem) async {
    try {
      final result = await dataSource.createBarterItem(barterItem);
      return Right(result);
    } on ServerException catch (_) {
      return const Left(ServerFailure(message: ''));
    } on CacheException catch (_) {
      return const Left(CacheFailure(message: ''));
    }
  }

  @override
  Future<Either<Failure, BarterItem?>>? getBarterItem(int id) async {
    try {
      final result = await dataSource.getBarterItem(id);
      return Right(result);
    } on ServerException catch (_) {
      return const Left(ServerFailure(message: ''));
    } on CacheException catch (_) {
      return const Left(CacheFailure(message: ''));
    }
  }

  @override
  Future<Either<Failure, List<BarterItem?>?>>? getAllBarterItems() async {
    try {
      final result = await dataSource.getAllItems();
      return Right(result);
    } on ServerException catch (_) {
      return const Left(ServerFailure(message: ''));
    } on CacheException catch (_) {
      return const Left(CacheFailure(message: ''));
    }
  }

  @override
  Future<Either<Failure, BarterItem?>>? updateBarterItem(
      BarterItem barterItem) async {
    try {
      final result = await dataSource.updateBarterItem(barterItem);
      return Right(result);
    } on ServerException catch (_) {
      return const Left(ServerFailure(message: ''));
    } on CacheException catch (_) {
      return const Left(CacheFailure(message: ''));
    }
  }

  @override
  Future<Either<Failure, bool?>>? deleteBarterItem(int id) async {
    try {
      final result = await dataSource.deleteBarterItem(id);
      return Right(result);
    } on ServerException catch (_) {
      return const Left(ServerFailure(message: ''));
    } on CacheException catch (_) {
      return const Left(CacheFailure(message: ''));
    }
  }
}
