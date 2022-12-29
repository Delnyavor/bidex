import 'package:bidex/common/widgets/image.dart';
import 'package:bidex/features/barter/domain/entities/barter_item.dart';
import 'package:bidex/features/barter/presentation/widgets/carousel.dart';
import 'package:bidex/features/barter/presentation/widgets/tags_widget.dart';
import 'package:flutter/material.dart';

class BarterItemWidget extends StatefulWidget {
  final BarterItem barterItem;
  const BarterItemWidget({Key? key, required this.barterItem})
      : super(key: key);

  @override
  State<BarterItemWidget> createState() => _BarterItemWidgetState();
}

class _BarterItemWidgetState extends State<BarterItemWidget> {
  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: decoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          itemHeader(),
          center(),
          controls(),
          tags(),
        ],
      ),
    );
  }

  Widget itemHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 6),
      child: Row(
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
                  widget.barterItem.username,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                ),
                Text(
                  widget.barterItem.location,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Colors.black87,
                      ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.star_rate_rounded,
                  size: 20,
                ),
                Text(
                  widget.barterItem.rating.toString(),
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget center() {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Carousel(
          images: widget.barterItem.imageUrls,
        ),
      ),
    );
  }

  Widget controls() {
    return Row(
      children: const [
        IconButton(
          constraints: BoxConstraints(maxWidth: 35),
          onPressed: null,
          iconSize: 22,
          icon: Icon(
            Icons.favorite,
          ),
        ),
        IconButton(
          constraints: BoxConstraints(maxWidth: 35),
          onPressed: null,
          iconSize: 22,
          icon: Icon(
            Icons.swap_vert,
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              iconSize: 20,
              onPressed: null,
              icon: Icon(
                Icons.share,
              ),
            ),
          ),
        )
      ],
    );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        const BoxShadow(
          color: Colors.black38,
          spreadRadius: -1,
          blurRadius: 1,
          offset: Offset(0, 0.5),
        ),
        BoxShadow(
          color: Colors.black12.withOpacity(0.2),
          spreadRadius: -5,
          blurRadius: 8,
          offset: Offset(0, 1),
        ),
      ],
    );
  }

  Widget tags() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
      child: TagsWidget(tags: widget.barterItem.tags),
    );
  }
}
