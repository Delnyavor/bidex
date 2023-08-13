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
  final List<String> imageUrls;
  final List<String> tags;

  const AuctionItem({
    required this.id,
    required this.userId,
    required this.username,
    required this.userImg,
    required this.location,
    required this.rating,
    required this.imageUrls,
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
        imageUrls,
        tags,
        name,
        category,
        startingPrice,
        description,
      ];
}
