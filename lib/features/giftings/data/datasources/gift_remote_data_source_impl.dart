import 'dart:convert';

import 'package:bidex/api/endpoints.dart';
import 'package:bidex/core/utils/decode.dart';
import 'package:bidex/features/giftings/domain/entities/gift_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../../../core/error/exceptions.dart';
import '../models/gift_item_model.dart';
import 'gift_remote_data_source.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class GiftRemoteDataSourceImpl extends GiftRemoteDataSource {
  final http.Client httpClient = http.Client();

  final sampleData = {
    "id": "1",
    "userId": "userId",
    "username": "username",
    "location": "location",
    "images": ["stock0.jpg", "stock1.jpg", "stock2.jpg", "stock3.jpg"],
    "userProfileImg": "stock0.jpg",
    "title": 'Custom Built Desktop',
    "description":
        "Lorem ipsum dolor sit amet lorem ipsum, dolor sit amet lorem ipsum dolor sit amet, lorem ipsum dolor sit amet",
    "criteria": "Athlete",
    "category": "category"
  };

  GiftRemoteDataSourceImpl();

  @override
  Future<GiftModel?>? createGift(
      Gift gift, String authToken, String refreshToken) async {
    var payload = jsonEncode((gift as GiftModel).toMap());

    debugPrint(payload);

    http.Response response = await httpClient
        .post(Uri.parse('https://bidex.up.railway.app/api/posts/'),
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
    //TODO: revert these changes

    // http.Response response = await httpClient.get(Uri.parse('www.example.com/'),
    //     headers: {'Content-Type': 'application/json'});
    try {
      // if (response.body.isNotEmpty) {}

      if (true) {
        // var res = jsonDecode(readFixture('barter_fixture.json'));
        // return compute(_parseItems, response.body);
        var item = GiftModel.fromMap(sampleData);

        Future.delayed(const Duration(seconds: 0), () {});
        return List<GiftModel>.generate(2, (index) => item);
      } else {
        // throw ServerException(code: response.statusCode);
      }
    } on PlatformException {
      return null;
    }
  }

  List<GiftModel> _parseItems(String responseBody) {
    final parsed = jsonDecode(responseBody).cast < Map<String, dynamic>;

    return parsed.map((item) => GiftModel.fromMap(item));
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
          return GiftModel.fromMap(sampleData);
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
