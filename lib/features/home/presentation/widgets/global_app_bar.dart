import 'package:bidex/common/widgets/translucent_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/transitions/route_transitions.dart';
import '../../../direct_messages/presentation/pages/direct_messages_page.dart';

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
    return AppBar(
      elevation: 0,
      systemOverlayStyle:
          CustomAppBar.translucentStatusAppBar.systemOverlayStyle,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: leading(),
      leadingWidth: 30,
      title: widget.title ?? title(),
      actions: widget.actions ?? actions(),
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

  Widget title() {
    return Image.asset(
      'assets/images/logo.png',
      height: 100,
    );
  }

  List<Widget> actions() {
    return [
      chatButton(),
      search(),
    ];
  }

  Widget chatButton() {
    return iconButton(
      onPressed: () {
        Navigator.push(
          context,
          slideInRoute(const DirectMessagesPage()),
        );
      },
      child: const Icon(
        CupertinoIcons.chat_bubble_2,
        size: 22,
      ),
    );
  }

  Widget search() {
    return iconButton(
      onPressed: () {},
      child: const Icon(
        CupertinoIcons.search,
        size: 22,
      ),
    );
  }

  Widget iconButton({required Function() onPressed, required Widget child}) {
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
