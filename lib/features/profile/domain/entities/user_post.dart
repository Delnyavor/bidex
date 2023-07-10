import 'package:equatable/equatable.dart';

class UserPost extends Equatable {
  final String imageUrl;
  final String type;
  final bool status;

  const UserPost(this.imageUrl, this.type, this.status);

  @override
  List<Object?> get props => [imageUrl, type, status];
}
