import 'dart:convert';

import 'package:bidex/api/endpoints.dart';
import 'package:bidex/core/utils/decode.dart';
import 'package:bidex/features/auth/data/datasources/local_data_source.dart';
import 'package:bidex/features/auth/domain/entities/user.dart';
import 'package:bidex/features/giftings/domain/entities/gift_item.dart';
import 'package:bidex/features/profile/domain/entities/user_post.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../../../core/error/exceptions.dart';
import '../models/gift_item_model.dart';
import 'gift_remote_data_source.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class GiftRemoteDataSourceImpl extends GiftRemoteDataSource {
  final http.Client httpClient = http.Client();
  final LocalAuthSource localAuthSource;

  GiftRemoteDataSourceImpl(this.localAuthSource);

  @override
  Future<GiftModel?>? createGift(
      Gift gift, String authToken, String refreshToken) async {
    var payload = jsonEncode((gift as GiftModel).toMap());

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
      return GiftModel.fromMap(decode(response.body));
    } else {
      throw ServerException(message: parseApiError(response.body));
    }
  }

  @override
  Future<bool?>? deleteGift(int id) async {
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
  Future<List<GiftModel>?>? getAllItems([int index = 0]) async {
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
  Future<GiftModel?>? getGift(int id) async {
    http.Response response = await httpClient.get(
        Uri.parse('www.example.com/$id'),
        headers: {'Content-Type': 'application/json'});
    try {
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          // TODO: change back to 'response,body'
          // return GiftModel.fromMap(jsonDecode(response.body));
          return GiftModel.fromMap(const {});
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
  Future<GiftModel?>? updateGift(Gift gift) async {
    http.Response response = await httpClient.post(
        Uri.parse('www.example.com/'),
        headers: {'Content-Type': 'application/json'});
    try {
      if (response.body.isNotEmpty) {
        return gift as GiftModel;
      } else {
        return null;
      }
    } on PlatformException {
      return null;
    }
  }
}

List<GiftModel> _parseItems(String responseBody) {
  final parsed = decode(responseBody) as List;
  List<GiftModel> result = [];
  for (dynamic item in parsed) {
    if (item["type"] == PostType.gift.name) {
      result.add(GiftModel.fromMap(item));
    }
  }

  return result;
}
