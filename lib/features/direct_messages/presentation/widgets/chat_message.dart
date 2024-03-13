import 'package:bidex/common/app_colors.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/chat.dart';

class ChatMessage extends StatelessWidget {
  final Chat message;
  final String? nextSender;
  const ChatMessage({
    super.key,
    required this.message,
    required this.nextSender,
  });

  @override
  Widget build(BuildContext context) {
    return message.user == '0000' ? sentMessage() : receivedMessage();
  }

  Widget sentMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Expanded(flex: 1, child: Center()),
        Flexible(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
            margin: EdgeInsets.only(bottom: nextSender == message.user ? 2 : 6),
            decoration: const BoxDecoration(
              color: AppColors.darkBlue,
              borderRadius: BorderRadius.horizontal(left: Radius.circular(14)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message.text,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 13, letterSpacing: 0),
                ),
                date(),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget date() {
    return Text(
      "${message.created.hour}:${message.created.minute}",
      style: const TextStyle(fontSize: 8, color: Colors.white54),
    );
  }

  Widget receivedMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
            margin: EdgeInsets.only(bottom: nextSender == message.user ? 2 : 6),
            decoration: const BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.horizontal(right: Radius.circular(14)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.text,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 13, letterSpacing: 0),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: date(),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Expanded(flex: 1, child: Center()),
      ],
    );
  }
}
