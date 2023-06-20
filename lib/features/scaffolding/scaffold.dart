import 'package:flutter/material.dart';

import '../../common/widgets/translucent_app_bar.dart';

class Scaffolding extends StatefulWidget {
  final Widget appBar;
  final Widget body;
  final Widget bottomNavbar;
  const Scaffolding(
      {Key? key,
      required this.appBar,
      required this.body,
      required this.bottomNavbar})
      : super(key: key);

  @override
  createState() => _Scaffolding();
}

class _Scaffolding extends State<Scaffolding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar.translucentStatusAppBar,
      body: body(),
      // bottomNavigationBar: widget.bottomNavbar,
    );
  }

  Widget body() {
    return Column(
      children: [
        widget.appBar,
        Flexible(
          child: bodyDecoration(),
        ),
        widget.bottomNavbar
      ],
    );
  }

  Widget bodyDecoration() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: DecoratedBox(
        decoration: decoration(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: widget.body,
        ),
      ),
    );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
      // color: Color(0xFFF9F9F9),
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: const [
        BoxShadow(
          spreadRadius: -5,
          blurRadius: 12,
          color: Colors.black26,
          offset: Offset(0, 2),
        ),
        BoxShadow(
          spreadRadius: 0,
          blurRadius: 1,
          color: Colors.black12,
          offset: Offset(0, 1),
        ),
      ],
    );
  }
}
