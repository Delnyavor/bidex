import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_colors.dart';

class SafetyAlert extends StatelessWidget {
  const SafetyAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          const Icon(
            CupertinoIcons.lock_shield_fill,
            size: 100,
          ),
          const Text(
            'Stay Alert!!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'User safety instructions go here',
              style: TextStyle(),
            ),
          ),
          button(context),
        ]),
      ),
    );
  }

  Widget button(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 60),
              backgroundColor: AppColors.darkBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: const Text(
              'CLOSE',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5),
            ),
          ),
        ),
      ],
    );
  }
}
