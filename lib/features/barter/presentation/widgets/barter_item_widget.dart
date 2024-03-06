import 'dart:ui';

import 'package:bidex/common/transitions/route_transitions.dart';
import 'package:bidex/common/widgets/carousel_indicator.dart';
import 'package:bidex/features/barter/domain/entities/barter_item.dart';
import 'package:bidex/common/widgets/carousel.dart';
import 'package:bidex/common/widgets/tags_widget.dart';
import 'package:bidex/features/barter/presentation/pages/barter_detail_page.dart';
import 'package:flutter/material.dart';

import '../../../../common/utils/description_text.dart';
import 'item_header.dart';

class BarterItemWidget extends StatefulWidget {
  final BarterItem barterItem;
  const BarterItemWidget({Key? key, required this.barterItem})
      : super(key: key);

  @override
  State<BarterItemWidget> createState() => _BarterItemWidgetState();
}

class _BarterItemWidgetState extends State<BarterItemWidget> {
  PageController controller = PageController();
  Duration duration = const Duration(milliseconds: 100);
  bool isOpen = false;

  void viewMore() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  void onTap() {
    Navigator.push(
        context, slideInRoute(BarterDetailPage(item: widget.barterItem)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: decoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ItemHeader(barterItem: widget.barterItem),
            ),
            center(),
            controls(),
            // tags(),
          ],
        ),
      ),
    );
  }

  Widget center() {
    return AspectRatio(
      aspectRatio: 1.4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Carousel(
              images: widget.barterItem.images.map((e) => e.url!).toList(),
              controller: controller,
            ),
            CarouselIndicator(
                controller: controller, count: widget.barterItem.images.length),
            if (isOpen) ...[overlayBuilder(backdrop())],
            Align(alignment: Alignment.bottomRight, child: viewMoreButton()),
          ],
        ),
      ),
    );
  }

  Widget overlayBuilder(Widget child) {
    return AnimatedOpacity(
      opacity: isOpen ? 1 : 0,
      duration: duration,
      child: child,
    );
  }

  Widget backdrop() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
      child: SizedBox.expand(
        child: overlayBuilder(itemDetails()),
      ),
    );
  }

  Widget itemDetails() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: const [
              Text(
                descriptionText,
                overflow: TextOverflow.ellipsis,
                maxLines: 50,
                style: TextStyle(
                  color: Colors.black87,
                  height: 1.4,
                  letterSpacing: 0,
                  fontSize: 13.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget viewMoreButton() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.5)),
        child: GestureDetector(
          onTap: viewMore,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: isOpen
                ? const Icon(Icons.keyboard_arrow_down)
                : const Icon(Icons.keyboard_arrow_up),
          ),
        ),
      ),
    );
  }

  Widget controls() {
    return const Row(
      children: [
        IconButton(
            constraints: BoxConstraints(maxWidth: 35),
            onPressed: null,
            iconSize: 22,
            icon: Icon(Icons.favorite)),
        IconButton(
            constraints: BoxConstraints(maxWidth: 35),
            onPressed: null,
            iconSize: 22,
            icon: Icon(Icons.swap_vert)),
        Expanded(
            child: Align(
          alignment: Alignment.centerRight,
          child: IconButton(
              iconSize: 20, onPressed: null, icon: Icon(Icons.share)),
        ))
      ],
    );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
      color: Colors.white70,
      borderRadius: BorderRadius.circular(20),
      // border: Border.all(color: Colors.grey.shade300, width: 0.5),
      // boxShadow: const [
      //   BoxShadow(
      //     spreadRadius: -5,
      //     blurRadius: 8,
      //     color: Colors.black26,
      //     offset: Offset(0, 0),
      //   ),
      //   BoxShadow(
      //     spreadRadius: 0,
      //     blurRadius: 1,
      //     color: Colors.black12,
      //     offset: Offset(0, 0),
      //   ),
      // ]
    );
  }

  // Widget tags() {
  //   return Padding(
  //     padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
  //     child: TagsWidget(tags: widget.barterItem),
  //   );
  // }
}
