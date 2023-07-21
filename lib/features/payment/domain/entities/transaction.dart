import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final String network;
  final String status;
  final String number;
  final DateTime date;

  const Transaction(
      {required this.network,
      required this.status,
      required this.number,
      required this.date});

  @override
  List<Object?> get props => [network, status, date, number];
}
