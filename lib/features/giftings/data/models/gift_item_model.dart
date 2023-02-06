import '../../domain/entities/gift_item.dart';

class GiftModel extends Gift {
  const GiftModel(
      {required super.id,
      required super.userId,
      required super.username,
      required super.userProfileImg,
      required super.location,
      required super.rating,
      required super.imageUrls,
      required super.title,
      required super.description});

  factory GiftModel.fromMap(Map data) {
    return GiftModel(
      id: data['id'],
      userId: data['userId'],
      username: data['username'],
      userProfileImg: data['userProfileImg'],
      location: data['location'],
      rating: data['rating'],
      imageUrls: data['imageUrls'],
      title: data['title'],
      description: data['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'username': username,
      'userProfileImg': userProfileImg,
      'location': location,
      'rating': rating,
      'imageUrls': imageUrls,
      'title': title,
      'description': description,
    };
  }
}
