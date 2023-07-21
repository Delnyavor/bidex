import 'package:flutter/material.dart';

import '../../../../common/utils/date_formatter.dart';
import '../../domain/entities/transaction.dart';

class TransactionWidget extends StatelessWidget {
  final Transaction transaction;
  const TransactionWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
      child: Row(
        children: [
          Expanded(flex: 1, child: network()),
          Expanded(flex: 2, child: number()),
          Expanded(flex: 2, child: status()),
          Expanded(flex: 2, child: date()),
        ],
      ),
    );
  }

  Widget network() {
    return Text(
      transaction.network.toUpperCase(),
      style: const TextStyle(
        letterSpacing: 0.7,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget number() {
    return Text(
      transaction.number.substring(6).padLeft(10, '*'),
      style: const TextStyle(
        letterSpacing: 0.7,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget status() {
    return Text(
      transaction.status.toUpperCase(),
      style: TextStyle(
        letterSpacing: 0.7,
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.greenAccent[700],
      ),
    );
  }

  Widget date() {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        DateFormatter(transaction.date).ddmm(),
        style: const TextStyle(
          letterSpacing: 0.7,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
