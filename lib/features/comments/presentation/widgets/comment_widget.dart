import 'package:bidex/common/app_colors.dart';
import 'package:bidex/features/comments/presentation/widgets/comment_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatefulWidget {
  final String data;
  const CommentWidget({super.key, required this.data});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool canViewReplies = false;
  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('assets/images/prof.jpg'),
          radius: 20,
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kong',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const Text(
              'Love the name',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                counter(),
                const SizedBox(width: 9),
                // reply(),
                // const SizedBox(width: 9),
                // viewReplies(),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ],
    );
  }

  Widget reply() {
    return InkWell(
      onTap: () {},
      child: const Text(
        'Reply',
        style: TextStyle(fontSize: 12, color: AppColors.blue),
      ),
    );
  }

  Widget viewReplies() {
    return InkWell(
      onTap: () {
        setState(() {
          canViewReplies = true;
        });
      },
      child: const Text(
        'View replies',
        style: TextStyle(fontSize: 12, color: AppColors.blue),
      ),
    );
  }

  Widget counter() {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(20)),
      child: const Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.flame_fill,
              size: 11,
            ),
            SizedBox(width: 2),
            Text(
              '23',
              style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
