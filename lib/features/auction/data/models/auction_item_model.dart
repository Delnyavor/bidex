import 'package:bidex/features/auction/domain/entities/auction_item.dart';

class AuctionItemModel extends AuctionItem {
  const AuctionItemModel(
      {required super.id,
      required super.username,
      required super.userId,
      required super.location,
      required super.rating,
      required super.imageUrls,
      required super.tags,
      required super.name,
      required super.category,
      required super.startingPrice,
      required super.description,
      required super.userImg});

  factory AuctionItemModel.fromMap(Map data) {
    return AuctionItemModel(
      id: data['id'],
      userId: data['userId'],
      username: data['username'],
      location: data['location'],
      rating: data['rating'],
      imageUrls: data['imageUrls'],
      tags: data['tags'],
      category: data['category'],
      description: data['description'],
      name: data['name'],
      startingPrice: data['starting_price'],
      userImg: data['user_img'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'username': username,
      'location': location,
      'rating': rating,
      'imageUrls': imageUrls,
      'tags': tags,
      'category': category,
      'description': description,
      'name': name,
      'starting_price': startingPrice,
      'user_img': userImg,
    };
  }
}
