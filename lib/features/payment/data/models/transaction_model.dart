import 'package:bidex/features/payment/domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  const TransactionModel(
      {required super.network,
      required super.status,
      required super.date,
      required super.number});

  factory TransactionModel.fromMap(Map data) {
    return TransactionModel(
      network: data['network'],
      status: data['status'],
      date: DateTime.fromMillisecondsSinceEpoch(data['date']),
      number: data['number'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'network': network,
      'status': status,
      'date': date.millisecondsSinceEpoch,
      'number': number,
    };
  }
}
