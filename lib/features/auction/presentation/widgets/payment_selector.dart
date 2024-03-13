import 'package:bidex/common/widgets/modal_form/heading.dart';
import 'package:bidex/common/widgets/modal_form/title.dart' as ttl;
import 'package:flutter/material.dart';

import '../../../../common/widgets/modal_form/button_cancel.dart';
import '../../../../common/widgets/modal_form/button_proceed.dart';

class PaymentSelector extends StatefulWidget {
  const PaymentSelector({super.key});

  @override
  State<PaymentSelector> createState() => _PaymentSelectorState();
}

class _PaymentSelectorState extends State<PaymentSelector> {
  PaymentOption? value;
  PaymentOption? groupValue;
  List<PaymentOption> options = const [
    PaymentOption(name: 'CASH', duration: Duration.zero),
    PaymentOption(name: 'VISA', duration: Duration.zero),
    PaymentOption(name: 'MOMO', duration: Duration.zero),
    PaymentOption(name: 'VF-CASH', duration: Duration.zero),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(26),
          ),
          child: Column(
            children: [
              body(),
              bottom(),
            ],
          ),
        ),
      ],
    );
  }

  Widget body() {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const ttl.Title(title: 'Payment Options'),
            const SizedBox(height: 10),
            radioSelector(options[0]),
            radioSelector(options[1]),
            radioSelector(options[2]),
            radioSelector(options[3]),
          ],
        ),
      ),
    );
  }

  Widget radioSelector(PaymentOption option) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Heading(heading: option.name),
        Radio<PaymentOption>(
          value: option,
          groupValue: groupValue,
          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.black87;
            }
            return Colors.black.withOpacity(0.6);
          }),
          onChanged: (PaymentOption? option) {
            setState(() {
              groupValue = option;
            });
          },
        ),
      ],
    );
  }

  Widget bottom() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CancelButton(
            text: 'CANCEL',
            coloured: false,
          ),
          const VerticalDivider(
            thickness: 5,
            width: 5,
            color: Colors.black,
          ),
          ProceedButton(
            text: 'PROCEED',
            onPressed: () {},
            colored: false,
          )
        ],
      ),
    );
  }
}

class PaymentOption {
  final String name;
  final Duration duration;

  const PaymentOption({required this.name, required this.duration});
}
