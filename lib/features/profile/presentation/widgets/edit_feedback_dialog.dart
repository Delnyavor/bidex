import 'package:flutter/material.dart';

class FeedbackDialog extends StatefulWidget {
  const FeedbackDialog({super.key});

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
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
              // bottom(),
            ],
          ),
        ),
      ],
    );
  }

  Widget body() {
    return const Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // const ttl.Title(title: 'Payment Options'),
            const SizedBox(height: 10),
            // radioSelector(options[0]),
            // radioSelector(options[1]),
            // radioSelector(options[2]),
            // radioSelector(options[3]),
          ],
        ),
      ),
    );
  }
}
