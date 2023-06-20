import 'package:flutter/material.dart';

import '../../../../common/widgets/image.dart';
import '../../domain/entities/barter_item.dart';

class ItemHeader extends StatelessWidget {
  final BarterItem barterItem;
  final bool showLast;
  const ItemHeader({super.key, required this.barterItem, this.showLast = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 15, 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: const DisplayImage(
              path: 'assets/images/stock0.jpg',
              height: 35,
              width: 35,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  barterItem.username,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                ),
                Text(
                  barterItem.location,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.black87,
                      ),
                ),
              ],
            ),
          ),
          showLast
              ? Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.star_rate_rounded,
                        size: 20,
                      ),
                      Text(
                        barterItem.rating.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black87),
                      )
                    ],
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
