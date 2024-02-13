import 'package:bidex/features/add_post/domain/entitites/image.dart';
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
      required super.images,
      required super.tags,
      required super.desiredItems,
      required super.id});

  factory BarterItemModel.fromMap(Map data) {
    var d = data['images'] as List<dynamic>;

    var imageList = d.map((e) => ApiImage(url: e)).toList();

    return BarterItemModel(
      userId: data['userId'],
      username: data['username'],
      location: data['location'],
      rating: data['rating'],
      itemName: data['item_name'],
      images: imageList,
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
      images: item.images,
      tags: item.tags,
      desiredItems: item.desiredItems,
    );
  }

  Map<String, dynamic> toMap() {
    var imagelist = images.map((e) => e.toJson()).toList();

    return {
      'name': itemName,
      'categoryId': 'clryy3pci0001mc0zmdv2rsf5',
      'description': description,
      'location': location,
      'barters': desiredItems,
      'images': imagelist,
    };
  }
}
