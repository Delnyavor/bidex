import 'package:flutter/material.dart';

import '../../app_colors.dart';

class ProceedButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool colored;
  const ProceedButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.colored = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        backgroundColor: colored ? AppColors.darkBlue : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Text(
        'PROCEED',
        style: TextStyle(
            color: !colored ? AppColors.darkBlue : Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5),
      ),
    );
  }
}
