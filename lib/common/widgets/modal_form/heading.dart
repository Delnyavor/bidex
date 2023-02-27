import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String heading;
  const Heading({Key? key, required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            // fontSize: 13,
          ),
    );
  }
}
