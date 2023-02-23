import 'package:bidex/features/auction/domain/entities/auction_item.dart';

class AuctionItemModel extends AuctionItem {
  const AuctionItemModel(
      {required int id,
      required String username,
      required String userId,
      required String location,
      required double rating,
      required List<String> imageUrls,
      required List<String> tags})
      : super(
          id: id,
          userId: userId,
          username: username,
          location: location,
          rating: rating,
          tags: tags,
          imageUrls: imageUrls,
        );

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
