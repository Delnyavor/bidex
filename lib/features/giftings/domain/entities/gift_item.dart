import 'package:equatable/equatable.dart';
import 'package:bidex/features/add_post/domain/entitites/image.dart';
class Gift extends Equatable {
  final String id;
  final String userId;
  final String username;
  final String userProfileImg;
  final String location;
  final List<ApiImage> images;
  final String name;
  final String description;
  final String criteria;
  final String category;

  const Gift({
    required this.id,
    required this.userId,
    required this.username,
    required this.location,
    required this.userProfileImg,
    required this.images,
    required this.name,
    required this.description,
    required this.criteria,
    required this.category,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        username,
        userProfileImg,
        location,
        images,
        name,
        description,
        criteria,
        category,
      ];
}
