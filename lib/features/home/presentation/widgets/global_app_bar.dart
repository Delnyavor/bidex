import 'package:bidex/common/widgets/translucent_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalAppBar extends StatefulWidget {
  final bool implyLeading;
  final List<Widget>? actions;
  final Widget? title;
  const GlobalAppBar(
      {Key? key, this.implyLeading = false, this.title, this.actions})
      : super(key: key);

  @override
  State<GlobalAppBar> createState() => _GlobalAppBarState();
}

class _GlobalAppBarState extends State<GlobalAppBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kBottomNavigationBarHeight,
      child: AppBar(
        elevation: 0,
        systemOverlayStyle:
            CustomAppBar.translucentStatusAppBar.systemOverlayStyle,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: leading(),
        leadingWidth: 30,
        title: widget.title,
        actions: widget.actions,
      ),
    );
  }

  Widget leading() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
      ),
      child: IconButton(
        onPressed: () {
          if (widget.implyLeading) {
            Navigator.pop(context);
          }
        },
        icon: Icon(
          widget.implyLeading
              ? CupertinoIcons.chevron_back
              : CupertinoIcons.plus_square,
          size: 22,
        ),
      ),
    );
  }
}
