import 'package:bidex/features/add_post/domain/entitites/image.dart';
import 'package:bidex/features/auth/data/models/user_model.dart';
import 'package:bidex/features/barter/domain/entities/barter_item.dart';

class BarterItemModel extends BarterItem {
  const BarterItemModel({
    required super.createdAt,
    required super.updatedAt,
    required super.id,
    required super.name,
    required super.description,
    required super.barters,
    required super.startingPrice,
    required super.priceCurrency,
    required super.recipientCriteria,
    required super.type,
    required super.status,
    required super.likeCount,
    required super.categoryId,
    required super.userId,
    required super.location,
    required super.images,
    required super.viewerCount,
    super.user,
  });

  factory BarterItemModel.fromMap(Map data) {
    var d = data['images'] as List<dynamic>;

    var imageList = d.map((e) => ApiImage(url: e)).toList();

    List<String> barters =
        (data["barters"] as List<dynamic>).map((e) => e as String).toList();

    return BarterItemModel(
        createdAt: data['createdAt'],
        updatedAt: data['updatedAt'],
        id: data['id'],
        name: data['name'],
        description: data['description'],
        barters: barters,
        startingPrice: data['starting_price'] ?? 0,
        priceCurrency: data['price_currency'] ?? '',
        recipientCriteria: data['recipient_criteria'] ?? '',
        type: data['type'],
        status: data['status'],
        likeCount: data['like_count'],
        categoryId: data['categoryId'],
        userId: data['userId'],
        location: data['location'],
        images: imageList,
        viewerCount: data['viewer_count'],
        user: data['user'] != null ? UserModel.fromMap(data['user']) : null);
  }

  factory BarterItemModel.fromBarterItem(BarterItem item) {
    return BarterItemModel(
      createdAt: item.createdAt,
      updatedAt: item.updatedAt,
      id: item.id,
      name: item.name,
      description: item.description,
      barters: item.barters,
      startingPrice: item.startingPrice,
      priceCurrency: item.priceCurrency,
      recipientCriteria: item.recipientCriteria,
      type: item.type,
      status: item.status,
      likeCount: item.likeCount,
      categoryId: item.categoryId,
      userId: item.userId,
      location: item.location,
      images: item.images,
      viewerCount: item.viewerCount,
    );
  }

  Map<String, dynamic> toMap() {
    var imagelist = images.map((e) => e.toJson()).toList();

    return {
      'name': name,
      'categoryId': 'clryy3pci0001mc0zmdv2rsf5',
      'description': description,
      'location': location,
      'barters': barters,
      'images': imagelist,
    };
  }
}
