import 'dart:convert';

import 'package:bidex/features/profile/data/datasources/user_posts_datasource.dart';
import 'package:bidex/features/profile/data/models/user_post_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';

class UserPostsDataSourceImpl implements UserPostsRemoteDataSource {
  @override
  Future<List<UserPostModel>?>? getUserPosts(int index) async {
    final http.Client httpClient = http.Client();

    try {
      http.Response response = await httpClient.get(
          Uri.parse('www.example.com/'),
          headers: {'Content-Type': 'application/json'});
      if (response.body.isNotEmpty) {
        return compute(_parseItems, response.body);
      } else {
        throw ServerException(code: response.statusCode);
      }
    } on PlatformException {
      return null;
    }
  }

  List<UserPostModel> _parseItems(String responseBody) {
    final parsed = jsonDecode(responseBody).cast < Map<String, dynamic>;

    return parsed.map((item) => UserPostModel.fromMap(item));
  }
}
