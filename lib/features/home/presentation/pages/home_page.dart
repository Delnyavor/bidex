import 'package:bidex/features/home/presentation/widgets/global_app_bar.dart';
import 'package:bidex/features/home/presentation/widgets/global_bottom_bar.dart';
import 'package:bidex/features/home/presentation/widgets/home_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/transitions/route_transitions.dart';
import '../../../direct_messages/presentation/pages/direct_messages_page.dart';
import '../../../scaffolding/scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffolding(
      appBar: GlobalAppBar(
        title: title(),
        actions: actions(),
      ),
      body: const HomeBody(),
      bottomNavbar: const GlobalBottomNavBar(),
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
