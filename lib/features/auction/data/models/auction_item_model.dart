import 'package:bidex/features/auction/domain/entities/auction_item.dart';

class AuctionItemModel extends AuctionItem {
  const AuctionItemModel(
      {required super.id,
      required super.username,
      required super.userId,
      required super.location,
      required super.rating,
      required super.imageUrls,
      required super.tags});

  factory AuctionItemModel.fromMap(Map data) {
    return AuctionItemModel(
        id: data['id'],
        userId: data['userId'],
        username: data['username'],
        location: data['location'],
        rating: data['rating'],
        imageUrls: data['imageUrls'],
        tags: data['tags']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'username': username,
      'location': location,
      'rating': rating,
      'imageUrls': imageUrls,
      'tags': tags
    };
  }
}
