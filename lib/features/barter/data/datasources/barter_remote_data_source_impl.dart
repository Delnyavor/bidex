import 'dart:convert';

import 'package:bidex/api/endpoints.dart';
import 'package:bidex/core/utils/decode.dart';
import 'package:bidex/features/barter/domain/entities/barter_item.dart';
import 'package:bidex/features/barter/data/models/barter_item_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import 'barter_remote_data_source.dart';

// TODO: clarify the endpoint return types for each function
class BarterRemoteDataSourceImpl extends BarterRemoteDataSource {
  final http.Client httpClient = http.Client();

  final sampleData = {
    "id": 1,
    "userId": "userId",
    "username": "username",
    "location": "location",
    "rating": 4.5,
    "images": ["stock0.jpg", "stock1.jpg", "stock2.jpg", "stock3.jpg"],
    "tags": ["ps5", "ps4", "gaming pc", "xbox series"],
    "item_name": "The Blue Dragon",
    "category": 'category',
    "description": 'description',
    "desired_items": ["ps5", "gaming pc", "ps4", "xbox series", "iPhone 13"]
  };

  BarterRemoteDataSourceImpl();

  @override
  @override
  Future<BarterItemModel?>? createBarterItem(
      BarterItem barter, String authToken, String refreshToken) async {
    var payload = jsonEncode((barter as BarterItemModel).toMap());

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
    //TODO: revert these changes

    // http.Response response = await httpClient.get(Uri.parse('www.example.com/'),
    //     headers: {'Content-Type': 'application/json'});
    try {
      // if (response.body.isNotEmpty) {}

      if (true) {
        // var res = jsonDecode(readFixture('barter_fixture.json'));
        // return compute(_parseItems, response.body);
        var item = BarterItemModel.fromMap(sampleData);

        return List<BarterItemModel>.generate(2, (index) => item);
      } else {
        // throw ServerException(code: response.statusCode);
      }
    } on PlatformException {
      return null;
    }
  }

  List<BarterItemModel> _parseItems(String responseBody) {
    final parsed = jsonDecode(responseBody).cast < Map<String, dynamic>;

    return parsed.map((item) => BarterItemModel.fromMap(item));
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
