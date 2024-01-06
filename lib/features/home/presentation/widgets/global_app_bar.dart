import 'package:bidex/common/widgets/navbar/nav_action_button.dart';
import 'package:bidex/common/widgets/translucent_app_bar.dart';
import 'package:bidex/features/add_post/presentation/pages/add_post_page.dart';
import 'package:bidex/features/direct_messages/presentation/pages/chat_page.dart';
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
  void navigateToCreatePostPage() {
    Navigator.push(context, fadeInRoute(const AddPostPage()));
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      systemOverlayStyle:
          CustomAppBar.translucentStatusAppBar.systemOverlayStyle,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: leading(),
      // leadingWidth: 30,
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
          } else {
            navigateToCreatePostPage();
          }
        },
        icon: Icon(
          widget.implyLeading
              ? CupertinoIcons.chevron_back
              : CupertinoIcons.plus_square,
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
      const SizedBox(width: 8),
    ];
  }

  Widget chatButton() {
    return NavActionButton(
      onPressed: () {
        Navigator.push(
          context,
          // slideInRoute(const DirectMessagesPage()),
          slideInRoute(const ChatPage()),
        );
      },
      child: const Icon(
        CupertinoIcons.chat_bubble_2,
      ),
    );
  }

  Widget search() {
    return NavActionButton(
      onPressed: () {},
      child: const Icon(
        CupertinoIcons.search,
        // size: 22,
      ),
    );
  }
}
