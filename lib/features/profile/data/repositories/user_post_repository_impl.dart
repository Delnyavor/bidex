import 'package:bidex/core/error/failures.dart';
import 'package:bidex/features/profile/data/datasources/user_posts_datasource.dart';

import 'package:bidex/features/profile/domain/entities/user_post.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/user_post_repository.dart';

class UserPostRepositoryImpl implements UserPostRepository {
  final UserPostsRemoteDataSource dataSource;

  UserPostRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<UserPost>?>>? getUserPosts(
      [int index = 0]) async {
    try {
      final result = await dataSource.getUserPosts(index);
      return Right(result);
    } on ServerException catch (_) {
      return const Left(ServerFailure(message: 'Something went wrong'));
    } on CacheException catch (_) {
      return const Left(CacheFailure(message: ''));
    }
  }
}
