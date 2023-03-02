import 'package:bidex/features/direct_messages/presentation/bloc/chat_bloc.dart';
import 'package:bidex/features/direct_messages/presentation/widgets/bottom_text_input.dart';
import 'package:bidex/features/direct_messages/presentation/widgets/chat_message.dart';
import 'package:bidex/features/direct_messages/presentation/widgets/safety_instructions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/navbar/nav_action_button.dart';
import '../../../../common/widgets/translucent_app_bar.dart';

class DirectMessagesPage extends StatefulWidget {
  const DirectMessagesPage({Key? key}) : super(key: key);

  @override
  createState() => _DirectMessagesPage();
}

class _DirectMessagesPage extends State<DirectMessagesPage> {
  TextEditingController controller = TextEditingController();

  late ChatBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ChatBloc>(context);
    bloc.add(const FetchChats());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle:
            CustomAppBar.translucentStatusAppBar.systemOverlayStyle,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: leading(),
        title: title(),
        actions: actions(),
      ),
      body: body(),
    );
  }

  Widget leading() {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        CupertinoIcons.chevron_back,
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
    return NavAction(
      onPressed: () {},
      child: const Icon(
        CupertinoIcons.chat_bubble_2,
        size: 22,
      ),
    );
  }

  Widget search() {
    return NavAction(
      onPressed: () {},
      child: const Icon(
        CupertinoIcons.search,
        size: 22,
      ),
    );
  }

  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(child: messages()),
        DMInput(controller: controller),
      ],
    );
  }

  Widget messages() {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: controls(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ChatMessage(message: state.items[index]);
              },
              childCount: state.items.length,
            ),
          )
        ],
      );
    });
  }

  Widget controls() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 5, 40),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/prof.jpg'),
          ),
          const SizedBox(width: 8),
          Column(
            children: const [
              Text(
                'Frank Oshlie',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('@oshfrank67'),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {}, icon: const Icon(CupertinoIcons.phone)),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SafetyAlert(),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(CupertinoIcons.lock_shield))
              ],
            ),
          )
        ],
      ),
    );
  }
}
