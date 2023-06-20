import 'package:flutter/material.dart';

import '../app_colors.dart';

class Tabs extends StatelessWidget {
  final TabController controller;
  final Function(int) onTap;
  const Tabs({super.key, required this.controller, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(18),
      ),
      child: TabBar(
        controller: controller,
        tabs: const [
          Tab(text: 'Details', height: 35),
          Tab(text: 'Bid', height: 35),
        ],
        unselectedLabelColor: AppColors.darkBlue,
        indicator: BoxDecoration(
          color: AppColors.darkBlue,
          borderRadius: BorderRadius.circular(18),
        ),
        onTap: onTap,
      ),
    );
  }
}
