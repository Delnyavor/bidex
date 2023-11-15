import 'dart:convert';

import 'package:bidex/api/endpoints.dart';
import 'package:bidex/core/utils/decode.dart';
import 'package:bidex/features/auction/data/datasources/auction_remote_data_source.dart';
import 'package:bidex/features/auction/data/models/auction_item_model.dart';
import 'package:bidex/features/auction/domain/entities/auction_item.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';

class AuctionRemoteDataSourceImpl extends AuctionRemoteDataSource {
  final http.Client httpClient = http.Client();

  AuctionRemoteDataSourceImpl();

  final sampleData = {
    "id": 1,
    "userId": "userId",
    "username": "username",
    "location": "location",
    "rating": 4.5,
    "imageUrls": ["stock0.jpg", "stock1.jpg", "stock2.jpg", "stock3.jpg"],
    "tags": ["ps5", "ps4", "gaming pc", "xbox series"],
    "category": "",
    "description": "",
    "name": "",
    "starting_price": "",
    "user_img": "",
  };

  @override
  Future<AuctionItemModel?>? createAuction(
      AuctionItem auction, String authToken, String refreshToken) async {
    http.Response response =
        await httpClient.post(Uri.parse(EndPoints.createAuctionUrl), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
      'refresh-token': refreshToken,
    }).timeout(const Duration(seconds: 2));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print(response.body);
      return AuctionItemModel.fromMap(decode(response.body));
    } else {
      throw ServerException(message: parseApiError(response.body));
    }
  }

  @override
  Future<bool?>? deleteAuction(int id) {
    // TODO: implement deleteAuction
    throw UnimplementedError();
  }

  @override
  Future<List<AuctionItemModel>?>? getAllItems(int index) async {
    //TODO: revert these changes

    // http.Response response = await httpClient.get(Uri.parse('www.example.com/'),
    //     headers: {'Content-Type': 'application/json'});
    try {
      // if (response.body.isNotEmpty) {}

      if (true) {
        // var res = jsonDecode(readFixture('barter_fixture.json'));
        // return compute(_parseItems, response.body);
        var item = AuctionItemModel.fromMap(sampleData);

        await Future.delayed(const Duration(seconds: 0), () {});
        return List<AuctionItemModel>.generate(2, (index) => item);
        // ignore: dead_code
      } else {
        // throw ServerException(code: response.statusCode);
      }
    } on PlatformException {
      return null;
    }
  }

  List<AuctionItemModel> _parseItems(String responseBody) {
    final parsed = jsonDecode(responseBody).cast < Map<String, dynamic>;

    return parsed.map((item) => AuctionItemModel.fromMap(item));
  }

  @override
  Future<AuctionItem?>? getAuction(int id) async {
    http.Response response = await httpClient.get(
        Uri.parse('www.example.com/$id'),
        headers: {'Content-Type': 'application/json'});
    try {
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          // TODO: change back to 'response,body'
          // return AuctionItemModel.fromMap(jsonDecode(response.body));
          return AuctionItemModel.fromMap(sampleData);
        } else {
          return null;
        }
      } else {
        throw const ServerException(message: "");
      }
    } on PlatformException {
      return null;
    }
  }

  @override
  Future<AuctionItem?>? updateAuction(AuctionItem auction) {
    // TODO: implement updateAuction
    throw UnimplementedError();
  }
}
