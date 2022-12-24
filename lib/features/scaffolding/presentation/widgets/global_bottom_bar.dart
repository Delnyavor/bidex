import 'package:bidex/features/scaffolding/presentation/widgets/bottom_nav_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalBottomNavBar extends StatefulWidget {
  const GlobalBottomNavBar({Key? key}) : super(key: key);

  @override
  State<GlobalBottomNavBar> createState() => _GlobalBottomNavBarState();
}

class _GlobalBottomNavBarState extends State<GlobalBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          BottomNavButton(
            label: 'Barter',
            icon: Icons.swap_vert,
            position: 0,
          ),
          BottomNavButton(
            label: 'Auction',
            icon: Icons.gavel_rounded,
            position: 1,
          ),
          BottomNavButton(
            label: 'Giftings',
            icon: CupertinoIcons.gift_alt,
            position: 2,
          ),
          BottomNavButton(
            label: 'Profile',
            icon: Icons.person,
            position: 3,
          ),
        ],
      ),
    );
  }
}
