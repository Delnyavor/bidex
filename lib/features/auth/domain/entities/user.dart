import 'package:bidex/features/add_post/domain/entitites/image.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String username;
  final String refreshToken;
  final String idToken;
  final String phone;
  final ApiImage photo;

  const User({
    required this.id,
    required this.photo,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.phone,
    required this.email,
    required this.refreshToken,
    required this.idToken,
  });

  @override
  List<Object?> get props => [
        id,
        photo,
        firstName,
        lastName,
        username,
        phone,
        email,
        refreshToken,
        idToken,
      ];
}
