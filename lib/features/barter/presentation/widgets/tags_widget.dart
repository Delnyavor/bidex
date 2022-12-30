import 'package:bidex/common/app_colors.dart';
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
              const Padding(
                padding: EdgeInsets.only(left: 3, right: 5),
                child: Text(
                  '|',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: AppColors.errorRed,
                  ),
                ),
              ),
            ],
          );
        }
        return Text(e, style: style());
      }).toList()),
    );
  }

  TextStyle style() {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      // fontStyle: FontStyle.italic,
      color: Colors.grey[700],
    );
  }
}
