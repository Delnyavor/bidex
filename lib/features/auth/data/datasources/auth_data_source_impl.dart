import 'dart:convert';

import 'package:bidex/core/error/exceptions.dart';
import 'package:bidex/features/auth/data/datasources/auth_data_source.dart';
import 'package:bidex/features/auth/data/models/user_model.dart';
import 'package:bidex/features/auth/domain/entities/user.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/decode.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final http.Client httpClient = http.Client();

  AuthDataSourceImpl();

  @override
  Future<User?> signIn(String email, String password) async {
    http.Response response = await httpClient.post(
        Uri.parse("https://bidex.up.railway.app/api/auth/signin/"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "email": email,
          "password": password,
        }));
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return _parseItems(response.body);
    } else {
      throw ServerException(message: parseApiError(response.body));
    }
  }

  @override
  Future<User?> createUser(String email, String password) async {
    http.Response response = await httpClient.post(
        Uri.parse("https://bidex.up.railway.app/api/auth/register/"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "email": email,
          "password": password,
        }));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return _parseItems(response.body);
    } else {
      throw ServerException(message: parseApiError(response.body));
    }
  }

  UserModel _parseItems(String responseBody) {
    return UserModel.fromMap(decode(responseBody));
  }

  @override
  Future getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  @override
  Future<User?> getUser(String id) async {
    // TODO: implement getUsers
    throw UnimplementedError();
  }

  @override
  Future<User?> updateUser(User user) async {
    http.Response response = await httpClient.patch(
      Uri.parse(
        "https://bidex.up.railway.app/api/users/${user.id}",
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user.idToken}'
      },
      body: jsonEncode({
        "email": user.email,
        "changes": {
          "username": user.username,
          "firstName": user.firstName,
          "lastName": user.lastName,
        }
      }),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return _parseItems(response.body);
    } else {
      throw ServerException(message: parseApiError(response.body));
    }
  }

  @override
  Future deleteUser() {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<bool?> verify(String password) async {
    // TODO: implement verify
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}
