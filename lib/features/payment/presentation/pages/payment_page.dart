import 'package:bidex/common/app_colors.dart';
import 'package:bidex/common/transitions/route_transitions.dart';
import 'package:bidex/common/widgets/modal_form/button_proceed.dart';
import 'package:bidex/features/home/presentation/widgets/global_app_bar.dart';
import 'package:bidex/features/payment/presentation/pages/create_payment_method_page.dart';
import 'package:bidex/features/payment/presentation/widgets/add_payment_method_card.dart';
import 'package:bidex/features/payment/presentation/widgets/transaction_widget.dart';
import 'package:bidex/features/scaffolding/scaffold.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/transaction.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  createState() => _PaymentPage();
}

class _PaymentPage extends State<PaymentPage> {
  List<Transaction> transactions = [
    Transaction(
        network: 'mtn',
        status: 'success',
        number: '0205001234',
        date: DateTime.now()),
    Transaction(
        network: 'voda',
        status: 'success',
        number: '0205001234',
        date: DateTime.now()),
    Transaction(
        network: 'mtn',
        status: 'success',
        number: '0205001234',
        date: DateTime.now()),
    Transaction(
        network: 'voda',
        status: 'success',
        number: '0205001234',
        date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffolding(
      backgroundColour: AppColors.darkBlue,
      appBar: const GlobalAppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
        children: [
          const AddPaymentMethodCard(),
          const SizedBox(height: 20),
          ...transactions
              .map((e) => TransactionWidget(transaction: e))
              .toList(),
        ],
      ),
      bottomNavbar: ProceedButton(
        onPressed: () {
          Navigator.push(context, fadeInRoute(const CreatePaymentMethodPage()));
        },
        text: 'CREATE PAYMENT METHOD',
      ),
    );
  }
}
