import 'package:bidex/features/payment/domain/entities/payment_method.dart';

class PaymentMethodModel extends PaymentMethod {
  const PaymentMethodModel({required super.name});

  factory PaymentMethodModel.fromMap(Map map) {
    return PaymentMethodModel(name: map['name']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
