import 'package:bidex/common/transitions/route_transitions.dart';
import 'package:bidex/common/widgets/translucent_app_bar.dart';
import 'package:bidex/features/direct_messages/presentation/pages/direct_messages_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalAppBar extends StatefulWidget {
  final bool implyLeading;
  const GlobalAppBar({Key? key, this.implyLeading = false}) : super(key: key);

  @override
  State<GlobalAppBar> createState() => _GlobalAppBarState();
}

class _GlobalAppBarState extends State<GlobalAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kBottomNavigationBarHeight,
      padding: const EdgeInsets.only(right: 0),
      child: AppBar(
        elevation: 0,
        systemOverlayStyle:
            CustomAppBar.translucentStatusAppBar.systemOverlayStyle,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: leading(),
        title: title(),
        actions: actions(),
      ),
    );
  }

  Widget leading() {
    return IconButton(
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
