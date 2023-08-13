import 'package:bidex/features/barter/domain/entities/barter_item.dart';

class BarterItemModel extends BarterItem {
  const BarterItemModel(
      {required super.description,
      required super.category,
      required super.userId,
      required super.username,
      required super.location,
      required super.rating,
      required super.itemName,
      required super.imageUrls,
      required super.tags,
      required super.desiredItems,
      required super.id});

  factory BarterItemModel.fromMap(Map data) {
    return BarterItemModel(
      userId: data['userId'],
      username: data['username'],
      location: data['location'],
      rating: data['rating'],
      itemName: data['item_name'],
      imageUrls: data['imageUrls'],
      tags: data['tags'],
      category: data['category'],
      description: data['description'],
      desiredItems: data['desired_items'],
      id: data['id'],
    );
  }

  factory BarterItemModel.fromBarterItem(BarterItem item) {
    return BarterItemModel(
        id: item.id,
        description: item.description,
        category: item.category,
        userId: item.userId,
        username: item.username,
        location: item.location,
        rating: item.rating,
        itemName: item.itemName,
        imageUrls: item.imageUrls,
        tags: item.tags,
        desiredItems: item.desiredItems);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'username': username,
      'location': location,
      'rating': rating,
      'imageUrls': imageUrls,
      'item_name': itemName,
      'tags': tags,
      'category': category,
      'description': description,
      'desired_items': desiredItems,
    };
  }
}
