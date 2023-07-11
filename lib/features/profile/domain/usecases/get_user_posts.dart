import 'package:bidex/features/profile/domain/repositories/user_post_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_post.dart';

class GetUserPosts {
  final UserPostRepository repository;
  GetUserPosts({required this.repository});

  Future<Either<Failure, List<UserPost>?>?>? call([int index = 0]) async {
    return await repository.getUserPosts(index);
  }
}
