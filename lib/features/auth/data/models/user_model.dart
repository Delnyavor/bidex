import 'package:bidex/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String firstName,
    required String lastName,
    required String email,
    required String username,
    required String photoUrl,
    required String phoneNumber,
  }) : super(
            firstName: firstName,
            lastName: lastName,
            email: email,
            username: username,
            photoUrl: photoUrl,
            phoneNumber: phoneNumber);

  factory UserModel.fromMap(Map data) {
    return UserModel(
      firstName: data['first_name'],
      lastName: data['last_name'],
      email: data['email'],
      username: data['username'],
      photoUrl: data['photoUrl'] ?? '',
      phoneNumber: data['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'username': username,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber
    };
  }
}
