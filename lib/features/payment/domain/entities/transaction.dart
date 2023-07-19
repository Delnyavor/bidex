import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final String network;
  final String status;
  final int date;

  const Transaction(
      {required this.network, required this.status, required this.date});

  @override
  List<Object?> get props => [network, status, date];
}
