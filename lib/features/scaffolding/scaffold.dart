import 'package:flutter/material.dart';

import '../../common/app_colors.dart';

class Scaffolding extends StatefulWidget {
  final Widget appBar;
  final Widget body;
  final Widget bottomNavbar;
  final Color? backgroundColour;
  const Scaffolding(
      {Key? key,
      required this.appBar,
      required this.body,
      required this.bottomNavbar,
      this.backgroundColour})
      : super(key: key);

  @override
  createState() => _Scaffolding();
}

class _Scaffolding extends State<Scaffolding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: widget.appBar,
      ),
      body: body(),
    );
  }

  Widget body() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.transparent,
              widget.backgroundColour ?? Colors.transparent,
            ],
            stops: const [0, 0.2],
          ),
        ),
        child: Column(
          children: [
            Flexible(
              child: bodyDecoration(),
            ),
            widget.bottomNavbar
          ],
        ),
      ),
    );
  }

  Widget bodyDecoration() {
    return DecoratedBox(
      decoration: decoration(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: widget.body,
      ),
    );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: const [
        BoxShadow(
          spreadRadius: -5,
          blurRadius: 8,
          color: Colors.black26,
          offset: Offset(0, 0),
        ),
        BoxShadow(
          spreadRadius: 0,
          blurRadius: 1,
          color: Colors.black12,
          offset: Offset(0, 0),
        ),
      ],
    );
  }
}
