import 'package:bidex/features/add_post/domain/entitites/image.dart';
import 'package:bidex/features/auction/domain/entities/auction_item.dart';

class AuctionItemModel extends AuctionItem {
  const AuctionItemModel(
      {required super.id,
      required super.username,
      required super.userId,
      required super.location,
      required super.rating,
      required super.images,
      required super.tags,
      required super.name,
      required super.category,
      required super.startingPrice,
      required super.description,
      required super.userImg});

  factory AuctionItemModel.fromMap(Map data) {
    var d = data['images'] as List<dynamic>;

    var imageList = d.map((e) => ApiImage(url: e)).toList();

    return AuctionItemModel(
      id: data['id'],
      userId: data['userId'],
      username: data['username'],
      location: data['location'],
      rating: data['rating'],
      images: imageList,
      tags: data['tags'],
      category: data['category'],
      description: data['description'],
      name: data['name'],
      startingPrice: data['starting_price'],
      userImg: data['user_img'],
    );
  }

  Map<String, dynamic> toMap() {
    var imagelist = images.map((e) => e.toJson()).toList();

    return {
      'id': id,
      'userId': userId,
      'username': username,
      'location': location,
      'rating': rating,
      'images': imagelist,
      'tags': tags,
      'categoryId': 'clryy3pci0001mc0zmdv2rsf5',
      'description': description,
      'name': name,
      'starting_price': startingPrice,
      'user_img': userImg,
    };
  }
}
