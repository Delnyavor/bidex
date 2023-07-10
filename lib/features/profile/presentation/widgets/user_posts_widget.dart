import 'package:flutter/material.dart';

class UserPostsWidget extends StatelessWidget {
  const UserPostsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white.withOpacity(0.5)),
      child: Column(
        children: [
          Align(
              alignment: Alignment.bottomRight, child: const Icon(Icons.menu)),
        ],
      ),
    );
  }
}
