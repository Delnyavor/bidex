import 'package:flutter/material.dart';

class Scaffolding extends StatefulWidget {
  final Widget appBar;
  final Widget body;
  final Widget bottomNavbar;
  final Color? backgroundColour;
  final bool? resizeToAvoidInsets;
  const Scaffolding(
      {super.key,
      required this.appBar,
      required this.body,
      required this.bottomNavbar,
      this.backgroundColour,
      this.resizeToAvoidInsets = false});

  @override
  createState() => _Scaffolding();
}

class _Scaffolding extends State<Scaffolding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: widget.resizeToAvoidInsets,
      backgroundColor: Colors.grey.shade100,
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
      child: Column(
        children: [
          Flexible(
            child: bodyDecoration(),
          ),
          widget.bottomNavbar
        ],
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
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(30),
    );
  }
}
