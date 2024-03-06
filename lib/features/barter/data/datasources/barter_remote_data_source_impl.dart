import 'dart:convert';

import 'package:bidex/api/endpoints.dart';
import 'package:bidex/core/utils/decode.dart';
import 'package:bidex/features/auth/data/datasources/local_data_source.dart';
import 'package:bidex/features/auth/domain/entities/user.dart';
import 'package:bidex/features/barter/domain/entities/barter_item.dart';
import 'package:bidex/features/barter/data/models/barter_item_model.dart';
import 'package:bidex/features/profile/domain/entities/user_post.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import 'barter_remote_data_source.dart';

class BarterRemoteDataSourceImpl extends BarterRemoteDataSource {
  final http.Client httpClient = http.Client();
  final LocalAuthSource localAuthSource;

  BarterRemoteDataSourceImpl(this.localAuthSource);

  @override
  Future<BarterItemModel?>? createBarterItem(
      BarterItem barterItem, String authToken, String refreshToken) async {
    var payload = jsonEncode((barterItem as BarterItemModel).toMap());

    debugPrint(payload);

    http.Response response = await httpClient
        .post(Uri.parse(EndPoints.fetchPosts),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $authToken',
              'refresh-token': refreshToken,
            },
            body: payload)
        .timeout(const Duration(seconds: 15));

    debugPrint(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return BarterItemModel.fromMap(decode(response.body));
    } else {
      throw ServerException(message: parseApiError(response.body));
    }
  }

  @override
  Future<bool?>? deleteBarterItem(int id) async {
    http.Response response = await httpClient.post(
        Uri.parse('www.example.com/$id'),
        headers: {'Content-Type': 'application/json'});
    try {
      if (response.body.isNotEmpty) {
        return false;
      } else {
        return null;
      }
    } on PlatformException {
      return null;
    }
  }

  @override
  Future<List<BarterItemModel>?>? getAllItems([int index = 0]) async {
    User user = await localAuthSource.getUser();
    String authToken = user.idToken;
    String refreshToken = user.refreshToken;

    http.Response response =
        await httpClient.get(Uri.parse(EndPoints.fetchPosts), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
      'refresh-token': refreshToken,
    }).timeout(const Duration(seconds: 15));
    debugPrint(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return compute(_parseItems, response.body);
    } else {
      throw ServerException(message: parseApiError(response.body));
    }
  }

  @override
  Future<BarterItemModel?>? getBarterItem(int id) async {
    http.Response response = await httpClient.get(
        Uri.parse('www.example.com/$id'),
        headers: {'Content-Type': 'application/json'});
    try {
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          return BarterItemModel.fromMap(jsonDecode(response.body));
        } else {
          return null;
        }
      } else {
        throw const ServerException();
      }
    } on PlatformException {
      return null;
    }
  }

  @override
  Future<BarterItemModel?>? updateBarterItem(BarterItem barterItem) async {
    http.Response response = await httpClient.post(
        Uri.parse('www.example.com/'),
        headers: {'Content-Type': 'application/json'});
    try {
      if (response.body.isNotEmpty) {
        return barterItem as BarterItemModel;
      } else {
        return null;
      }
    } on PlatformException {
      return null;
    }
  }
}

List<BarterItemModel> _parseItems(String responseBody) {
  final parsed = decode(responseBody) as List;
  List<BarterItemModel> result = [];
  for (dynamic item in parsed) {
    if (item["type"] == PostType.barter.name) {
      result.add(BarterItemModel.fromMap(item));
    }
  }

  return result;
}
