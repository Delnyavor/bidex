import 'package:bidex/features/direct_messages/presentation/bloc/chat_bloc.dart';
import 'package:bidex/features/direct_messages/presentation/widgets/bottom_text_input.dart';
import 'package:bidex/features/direct_messages/presentation/widgets/chat_message.dart';
import 'package:bidex/features/direct_messages/presentation/widgets/controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(scrollController.hasClients);
  }

  void addListener() {
    scrollController.addListener(() {
      print("OFFSET: ${scrollController.offset}");
      print("MAX EXTENT: ${scrollController.position.maxScrollExtent}");
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addListener();
    });
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/chat_bg.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: body(),
      ),
    );
  }

  Widget body() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 25),
            child: const ChatControls(),
          ),
        ),
        body: messages(),
        bottomNavigationBar: chatBox(),
        resizeToAvoidBottomInset: true,
      ),
    );
  }

  Widget messages() {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      return ListView.builder(
        reverse: true,
        padding: const EdgeInsets.only(top: 15),
        controller: scrollController,
        itemBuilder: (ctx, index) {
          String? next = (index < state.items.length - 1)
              ? state.items[index + 1].user
              : null;

          return ChatMessage(
            message: state.items[index],
            nextSender: next,
          );
        },
        itemCount: state.items.length,
      );
    });
  }

  Widget chatBox() {
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(offset: Offset(0, 0), spreadRadius: -1, blurRadius: 1),
        ],
      ),
      child: DMInput(controller: controller),
    );
  }
}
