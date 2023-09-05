import 'package:equatable/equatable.dart';

class Gift extends Equatable {
  final int id;
  final String userId;
  final String username;
  final String userProfileImg;
  final String location;
  final double rating;
  final List<String> imageUrls;
  final String title;
  final String description;
  final String criteria;
  final String category;

  const Gift({
    required this.id,
    required this.userId,
    required this.username,
    required this.location,
    required this.rating,
    required this.userProfileImg,
    required this.imageUrls,
    required this.title,
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
        rating,
        imageUrls,
        title,
        description,
        criteria,
        category,
      ];
}
