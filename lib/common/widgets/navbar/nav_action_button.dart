import 'package:flutter/material.dart';

class NavAction extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  const NavAction({Key? key, required this.onPressed, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: child,
        ),
      ),
    );
  }
}
