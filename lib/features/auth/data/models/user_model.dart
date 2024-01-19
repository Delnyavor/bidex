import 'package:bidex/features/add_post/domain/entitites/image.dart';
import 'package:bidex/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.photo,
    required super.firstName,
    required super.lastName,
    required super.username,
    required super.phone,
    required super.email,
    required super.refreshToken,
    required super.idToken,
  });

  factory UserModel.fromMap(Map data) {
    return UserModel(
      id: data['id'] ?? '',
      email: data['email'] ?? '',
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      username: data['username'] ?? '',
      phone: data['phone'] ?? '',
      photo: ApiImage(url: data['photo']),
      idToken: data['idToken'] ?? '',
      refreshToken: data['refreshToken'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "username": username,
      "phone": phone,
      "photo": photo.toJson(),
    };
  }
}
