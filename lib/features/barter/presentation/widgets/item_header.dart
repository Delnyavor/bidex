import 'package:flutter/material.dart';

import '../../../../common/widgets/image.dart';

class ItemHeader extends StatelessWidget {
  final dynamic item;
  final bool showLast;
  const ItemHeader({super.key, required this.item, this.showLast = false});

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
              path: 'assets/images/prof.jpg',
              height: 35,
              width: 35,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // "${item.user?.firstName} ${item.user?.lastName}",
                    item.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Bimpong Amoako',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.black87,
                            ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        item.location,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.black87,
                            ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '4.0',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.black87,
                            ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          showLast
              ? const Icon(
                  Icons.share,
                  size: 20,
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
