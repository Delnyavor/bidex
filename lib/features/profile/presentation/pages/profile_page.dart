import 'package:bidex/features/profile/presentation/widgets/dropdown_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/image_resources.dart';
import '../widgets/dropdown_filter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  double spacing = 16.0;

  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(spacing),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              mainAxisSpacing: spacing,
              crossAxisSpacing: spacing),
          itemBuilder: (c, i) {
            return Image.asset(
              ImageResources.stock1,
              fit: BoxFit.cover,
            );
          },
          itemCount: 3,
        ),
      ),
      floatingActionButton: DecoratedBox(
        key: key,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColors.buttonLightBlue,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FilterDropdown(parentKey: key),
              const SizedBox(width: 14),
              const Icon(CupertinoIcons.plus_square),
              const SizedBox(width: 14),
              ProfileMenuDropdown(parentKey: key),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
