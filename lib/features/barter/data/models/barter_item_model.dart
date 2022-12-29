import 'package:bidex/features/barter/domain/entities/barter_item.dart';

class BarterItemModel extends BarterItem {
  const BarterItemModel(
      {required String username,
      required String userId,
      required String location,
      required double rating,
      required List<String> imageUrls,
      required List<String> tags})
      : super(
          userId: userId,
          username: username,
          location: location,
          rating: rating,
          tags: tags,
          imageUrls: imageUrls,
        );

  factory BarterItemModel.fromMap(Map data) {
    return BarterItemModel(
        userId: data['userId'],
        username: data['username'],
        location: data['location'],
        rating: data['rating'],
        imageUrls: data['imageUrls'],
        tags: data['tags']);
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'location': location,
      'rating': rating,
      'imageUrls': imageUrls,
      'tags': tags
    };
  }
}
