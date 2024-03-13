import 'package:bidex/features/direct_messages/presentation/bloc/chat_bloc.dart';
import 'package:bidex/features/direct_messages/presentation/widgets/bottom_text_input.dart';
import 'package:bidex/features/direct_messages/presentation/widgets/chat_message.dart';
import 'package:bidex/features/direct_messages/presentation/widgets/safety_instructions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/presentation/widgets/global_app_bar.dart';
import '../../../scaffolding/scaffold.dart';

class DirectMessagesPage extends StatefulWidget {
  const DirectMessagesPage({super.key});

  @override
  createState() => _DirectMessagesPage();
}

class _DirectMessagesPage extends State<DirectMessagesPage> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();

  late ChatBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ChatBloc>(context);
    bloc.add(const FetchChats());
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print(true);
      scrollController.addListener(() {
        print(false);
        if (scrollController.position.atEdge) {
          print(scrollController.offset);
        }
      });
    });
    return Scaffolding(
      appBar: const GlobalAppBar(),
      body: messages(),
      resizeToAvoidInsets: true,
      bottomNavbar: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: DMInput(controller: controller),
      ),
    );
  }

  Widget messages() {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      return DecoratedBox(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/chat_bg.png'),
                fit: BoxFit.cover)),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: controls(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return null;

                  // return ChatMessage(message: state.items[index]);
                },
                childCount: state.items.length,
              ),
            ),
            const SliverFillRemaining(
              child: SizedBox.expand(),
            )
          ],
        ),
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
          const Column(
            children: [
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
                          return const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
