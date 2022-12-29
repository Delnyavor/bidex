import 'package:flutter/material.dart';

class TagsWidget extends StatelessWidget {
  final List<String> tags;
  const TagsWidget({Key? key, required this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
          children: tags.map((e) {
        if (e != tags.last) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(e, style: style()),
              const Text(' || '),
            ],
          );
        }
        return Text(e, style: style());
      }).toList()),
    );
  }

  TextStyle style() {
    return const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
    );
  }
}
