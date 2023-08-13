import 'package:equatable/equatable.dart';

class UserPost extends Equatable {
  final String imageUrl;
  final PostType type;
  final PostStatus status;

  const UserPost(this.imageUrl, this.type, this.status);

  @override
  List<Object?> get props => [imageUrl, type, status];
}

enum PostStatus { published, underReview }

enum PostType { gift, auction, barter }
