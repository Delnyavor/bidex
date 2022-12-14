import 'package:bidex/features/auth/data/datasources/auth_data_source.dart';
import 'package:bidex/features/auth/data/models/user_model.dart';
import 'package:bidex/features/auth/domain/entities/user.dart';
import 'package:bidex/features/auth/domain/entities/user_data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseDatabase firebaseDatabase;

  AuthDataSourceImpl({required this.firebaseDatabase});

  @override
  Future<User?> createUser(UserData userData, String uid) async {
    DatabaseReference ref = firebaseDatabase.ref().child("users");
    try {
      final postkey = ref.push().key;

      final Map<String, Map> data = {};

      data['/$uid'] = {
        "first_name": userData.firstName,
        "last_name": userData.lastName,
        "email": userData.email,
        "username": userData.username,
        "phone": userData.phoneNumber,
      };

      ref.update(data);

      //todo: create userdata to user method
    } on FirebaseException {
      return null;
    }
  }

  @override
  Future getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  @override
  Future<User?> getUser(String id) async {
    DatabaseReference ref = firebaseDatabase.ref().child("users/$id");

    try {
      DataSnapshot result = await ref.get();

      return UserModel.fromMap(result.value as Map);
    } on FirebaseException {
      return null;
    }
  }

  @override
  Future modifyUser() {
    // TODO: implement modifyUser
    throw UnimplementedError();
  }

  @override
  Future updateUser() {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future deleteUser() {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }
}
