import 'package:flutter/material.dart';

class NavActionButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  const NavActionButton(
      {super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
          child: child,
        ),
      ),
    );
  }
}
