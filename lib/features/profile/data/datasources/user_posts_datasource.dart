import 'package:bidex/features/profile/data/models/user_post_model.dart';

abstract class UserPostsRemoteDataSource {
  Future<List<UserPostModel>?>? getUserPosts(int index);
  // Future<Either<Failure, UserPost?>>? createUserPost(UserPost userPost);
  // Future<Either<Failure, UserPost?>>? getUserPost(int id);
  // Future<Either<Failure, UserPost?>>? updateUserPost(UserPost userPost);
  // Future<Either<Failure, bool?>>? deleteUserPost(int id);
}
