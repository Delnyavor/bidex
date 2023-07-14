// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

import "../../domain/entities/user_post.dart";

class UserPostWidget extends StatefulWidget {
  final UserPost post;
  const UserPostWidget({super.key, required this.post});

  @override
  State<UserPostWidget> createState() => _UserPostWidgetState();
}

class _UserPostWidgetState extends State<UserPostWidget> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black.withOpacity(0.05),
        image: DecorationImage(
            image: AssetImage(widget.post.imageUrl), fit: BoxFit.cover),
      ),
      child: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              buildTypeIndicator(),
              const SizedBox(width: 4),
              buildTypeIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTypeIndicator() {
    late IconData data;

    if (widget.post.type == PostType.barter) {
      data = Icons.swap_vert;
    } else if (widget.post.type == PostType.auction) {
      data = Icons.gavel_rounded;
    } else {
      data = CupertinoIcons.gift_alt;
    }

    return indicator(data);
  }

  Widget indicator(IconData data) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black.withOpacity(0.45),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          data,
          color: Colors.grey.shade100,
          size: 14,
        ),
      ),
    );
  }
}
