import '../../domain/entities/user_post.dart';

class UserPostModel extends UserPost {
  const UserPostModel(super.imageUrl, super.type, super.status);

  factory UserPostModel.fromMap(Map data) {
    return UserPostModel(
      data['imageUrl'],
      data['type'],
      data['status'],
    );
  }
}
