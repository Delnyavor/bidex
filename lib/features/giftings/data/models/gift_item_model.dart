import 'package:bidex/features/auth/data/models/user_model.dart';

import '../../domain/entities/gift_item.dart';
import 'package:bidex/features/add_post/domain/entitites/image.dart';

class GiftModel extends Gift {
  const GiftModel({
    required super.id,
    required super.userId,
    required super.username,
    required super.userProfileImg,
    required super.location,
    required super.images,
    required super.name,
    required super.description,
    required super.criteria,
    required super.category,
    super.user,
  });

  factory GiftModel.fromMap(Map data) {
    var d = data['images'] as List<dynamic>;

    var imageList = d.map((e) => ApiImage(url: e)).toList();
    return GiftModel(
        id: data['id'] ?? '',
        userId: data['userId'] ?? '',
        username: data['username'] ?? '',
        userProfileImg: data['userProfileImg'] ?? '',
        location: data['location'] ?? '',
        images: imageList,
        name: data['name'] ?? '',
        description: data['description'] ?? '',
        criteria: data['recipient_criteria'] ?? '',
        category: data['category'] ?? '',
        user: data['user'] != null ? UserModel.fromMap(data['user']) : null);
  }

  factory GiftModel.fromGift(Gift item) {
    return GiftModel(
      id: item.id,
      userId: item.userId,
      username: item.username,
      userProfileImg: item.userProfileImg,
      location: item.location,
      images: item.images,
      name: item.name,
      description: item.description,
      criteria: item.criteria,
      category: item.category,
    );
  }

  Map<String, dynamic> toMap() {
    var imagelist = images.map((e) => e.toJson()).toList();
    return {
      'name': name,
      'categoryId': 'clryy3pci0001mc0zmdv2rsf5',
      'description': description,
      'recipient_criteria': criteria,
      'location': location,
      'images': imagelist,
    };
  }
}
