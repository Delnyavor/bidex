import 'dart:io';

import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String username;
  final String phoneNumber;
  final File displayImage;

  const UserData(
      {required this.password,
      required this.displayImage,
      required this.firstName,
      required this.lastName,
      required this.username,
      required this.phoneNumber,
      required this.email});

  @override
  List<Object?> get props => [
        password,
        displayImage,
        firstName,
        lastName,
        username,
        phoneNumber,
        email
      ];
}
