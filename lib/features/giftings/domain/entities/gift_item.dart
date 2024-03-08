import 'package:bidex/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:bidex/features/add_post/domain/entitites/image.dart';

class Gift extends Equatable {
  final String createdAt;
  final String updatedAt;
  final String name;
  final String id;
  final String description;
  final List<String> barters;
  final double startingPrice;
  final String priceCurrency;
  final String recipientCriteria;
  final String type;
  final String status;
  final int likeCount;
  final String categoryId;
  final String userId;
  final String location;
  final List<ApiImage> images;
  final int viewerCount;
  final User? user;

  const Gift({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.name,
    required this.description,
    required this.barters,
    required this.startingPrice,
    required this.priceCurrency,
    required this.recipientCriteria,
    required this.type,
    required this.status,
    required this.likeCount,
    required this.categoryId,
    required this.userId,
    required this.location,
    required this.images,
    required this.viewerCount,
    this.user,
  });

  @override
  List<Object?> get props => [
        createdAt,
        updatedAt,
        id,
        name,
        description,
        barters,
        startingPrice,
        priceCurrency,
        recipientCriteria,
        type,
        status,
        likeCount,
        categoryId,
        userId,
        location,
        images,
        viewerCount,
        user,
      ];
}
