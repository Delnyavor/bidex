import 'package:equatable/equatable.dart';

class AuctionItem extends Equatable {
  final int id;
  final String userId;
  final String username;
  final String location;
  final double rating;
  final List<String> imageUrls;
  final List<String> tags;

  const AuctionItem(
      {required this.id,
      required this.userId,
      required this.username,
      required this.location,
      required this.rating,
      required this.imageUrls,
      required this.tags});

  @override
  List<Object?> get props =>
      [id, userId, username, location, rating, imageUrls, tags];
}
