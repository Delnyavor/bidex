import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String heading;
  const Heading({super.key, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            // fontSize: 13,
          ),
    );
  }
}
