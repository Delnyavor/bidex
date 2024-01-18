import 'package:bidex/features/add_post/domain/entitites/image.dart';
import 'package:equatable/equatable.dart';

class AuctionItem extends Equatable {
  final int id;
  final String userId;
  final String username;
  final String userImg;
  final String name;
  final String category;
  final String startingPrice;
  final String description;
  final String location;
  final double rating;
  final List<ApiImage> images;
  final List<String> tags;

  const AuctionItem({
    required this.id,
    required this.userId,
    required this.username,
    required this.userImg,
    required this.location,
    required this.rating,
    required this.images,
    required this.tags,
    required this.name,
    required this.category,
    required this.startingPrice,
    required this.description,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        username,
        userImg,
        location,
        rating,
        images,
        tags,
        name,
        category,
        startingPrice,
        description,
      ];
}
