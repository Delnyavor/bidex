import 'package:flutter/material.dart';

import '../../app_colors.dart';

class Title extends StatelessWidget {
  final String title;
  const Title({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkBlue,
          ),
    );
  }
}
