import 'package:flutter/material.dart';

import '../app_colors.dart';

class Tabs extends StatelessWidget {
  final TabController controller;
  final Function(int) onTap;
  final List<String> labels;
  const Tabs(
      {super.key,
      required this.controller,
      required this.onTap,
      required this.labels});

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
        tabs: [
          Tab(text: labels.first, height: 35),
          Tab(text: labels.last, height: 35),
        ],
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: AppColors.darkBlue,
        labelColor: AppColors.lightBlue,
        indicator: BoxDecoration(
          color: AppColors.darkBlue,
          borderRadius: BorderRadius.circular(18),
        ),
        dividerHeight: 0,
        onTap: onTap,
      ),
    );
  }
}
