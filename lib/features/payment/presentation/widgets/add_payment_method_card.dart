import 'package:bidex/common/app_colors.dart';
import 'package:bidex/common/utils/date_formatter.dart';
import 'package:flutter/material.dart';

class AddPaymentMethodCard extends StatefulWidget {
  const AddPaymentMethodCard({super.key});

  @override
  State<AddPaymentMethodCard> createState() => _AddPaymentMethodCardState();
}

class _AddPaymentMethodCardState extends State<AddPaymentMethodCard> {
  TextStyle style = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
  );

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.9,
      child: card(),
    );
  }

  Widget card() {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.darkBlue,
            AppColors.blue.withOpacity(0.95),
          ],
          stops: const [0, 0.8],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topRow(),
            middleRow(),
            const SizedBox(height: 8),
            date(),
          ],
        ),
      ),
    );
  }

  Widget topRow() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'NEW',
            style: style,
          ),
          const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget middleRow() {
    return Text(
      'Click to add new payment method',
      style: style,
    );
  }

  Widget date() {
    return Text(
      DateFormatter(DateTime.now()).mmyy(),
      style: style,
    );
  }
}
