import 'package:bidex/features/add_post/domain/entitites/image.dart';
import 'package:equatable/equatable.dart';

class BarterItem extends Equatable {
  final int id;
  final String userId;
  final String username;
  final String itemName;
  final String location;
  final double rating;
  final List<ApiImage> images;
  final List<String> tags;
  final String description;
  final String category;
  final List<String> desiredItems;

  const BarterItem({
    required this.id,
    required this.userId,
    required this.username,
    required this.itemName,
    required this.location,
    required this.rating,
    required this.images,
    required this.tags,
    required this.description,
    required this.category,
    required this.desiredItems,
  });

  @override
  List<Object?> get props => [
        userId,
        username,
        itemName,
        location,
        rating,
        images,
        tags,
        description,
        category,
        desiredItems,
      ];
}
