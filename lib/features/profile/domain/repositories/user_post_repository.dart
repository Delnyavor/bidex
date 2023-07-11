import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_post.dart';

abstract class UserPostRepository {
  Future<Either<Failure, List<UserPost>?>>? getUserPosts([int index]);
  // Future<Either<Failure, UserPost?>>? createUserPost(UserPost userPost);
  // Future<Either<Failure, UserPost?>>? getUserPost(int id);
  // Future<Either<Failure, UserPost?>>? updateUserPost(UserPost userPost);
  // Future<Either<Failure, bool?>>? deleteUserPost(int id);
}
