import 'package:bidex/features/direct_messages/presentation/widgets/safety_instructions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatControls extends StatelessWidget {
  const ChatControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 5, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.keyboard_arrow_left_rounded),
            ),
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/prof.jpg'),
          ),
          const SizedBox(width: 8),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
