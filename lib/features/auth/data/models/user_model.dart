import 'package:bidex/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    required String username,
    required String phone,
    required String photo,
    required String idToken,
    required String refreshToken,
  }) : super(
          id: id,
          photo: photo,
          firstName: firstName,
          lastName: lastName,
          username: username,
          phone: phone,
          email: email,
          idToken: idToken,
          refreshToken: refreshToken,
        );

  factory UserModel.fromMap(Map data) {
    return UserModel(
      id: data['id'] ?? '',
      email: data['email'] ?? '',
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      username: data['username'] ?? '',
      phone: data['phone'] ?? '',
      photo: data['photo'] ?? '',
      idToken: data['idToken'] ?? '',
      refreshToken: data['refreshToken'] ?? '',
    );
  }

  factory UserModel.empty() {
    return const UserModel(
      id: '',
      email: '',
      firstName: '',
      lastName: '',
      username: '',
      phone: '',
      photo: '',
      idToken: '',
      refreshToken: '',
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
      "photo": photo,
    };
  }
}
