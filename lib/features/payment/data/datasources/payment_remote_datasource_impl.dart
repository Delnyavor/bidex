import 'dart:convert';

import 'package:bidex/features/payment/data/datasources/payment_remote_datasource.dart';
import 'package:bidex/features/payment/data/models/payment_method_model.dart';
import 'package:bidex/features/payment/domain/entities/payment_method.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';

class PaymentRemoteDataSourceImpl extends PaymentRemoteDataSource {
  final http.Client httpClient = http.Client();

  PaymentRemoteDataSourceImpl();

  @override
  Future<PaymentMethod?>? createPaymentMethod(
      PaymentMethod paymentMethod) async {
    http.Response response = await httpClient.post(
        Uri.parse('www.example.com/'),
        headers: {'Content-Type': 'application/json'});
    try {
      if (response.body.isNotEmpty) {
        return paymentMethod;
      } else {
        throw ServerException;
      }
    } on PlatformException {
      return null;
    }
  }

  @override
  Future<List<PaymentMethodModel>?>? getAllMethods(int index) async {
    http.Response response = await httpClient.get(Uri.parse('www.example.com/'),
        headers: {'Content-Type': 'application/json'});
    try {
      if (response.body.isNotEmpty) {
        return compute(_parseItems, response.body);
      } else {
        throw const ServerException();
      }
    } on PlatformException {
      return null;
    }
  }

  List<PaymentMethodModel> _parseItems(String responseBody) {
    final parsed = jsonDecode(responseBody).cast < Map<String, dynamic>;

    return parsed.map((item) => PaymentMethodModel.fromMap(item));
  }

  @override
  Future<bool?>? deletePaymentMethod(int id) {
    // TODO: implement deletePaymentMethod
    throw UnimplementedError();
  }

  @override
  Future<PaymentMethodModel?>? getPaymentMethod(int id) async {
    http.Response response = await httpClient.get(
        Uri.parse('www.example.com/$id'),
        headers: {'Content-Type': 'application/json'});
    try {
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          return PaymentMethodModel.fromMap(jsonDecode(response.body));
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
}
