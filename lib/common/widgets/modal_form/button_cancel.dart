import 'package:bidex/common/app_colors.dart';
import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  final String text;
  final bool coloured;
  final Function? onPop;
  const CancelButton(
      {super.key, required this.text, this.coloured = true, this.onPop});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (onPop != null) {
          onPop!();
        }
        Navigator.of(context).pop();
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: coloured ? AppColors.darkBlue : Colors.black87),
      ),
    );
  }
}
