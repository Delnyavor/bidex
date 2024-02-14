import 'dart:ui';

import 'package:bidex/common/transitions/route_transitions.dart';
import 'package:bidex/common/widgets/carousel_indicator.dart';
import 'package:bidex/features/barter/domain/entities/barter_item.dart';
import 'package:bidex/common/widgets/carousel.dart';
import 'package:bidex/common/widgets/tags_widget.dart';
import 'package:bidex/features/barter/presentation/pages/barter_details_page.dart';
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
        context, slideInRoute(BarterDetailsPage(item: widget.barterItem)));
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
            tags(),
          ],
        ),
      ),
    );
  }

  Widget center() {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Carousel(
              images: widget.barterItem.imageUrls,
              controller: controller,
            ),
            if (isOpen) ...[overlayBuilder(backdrop())],
            Align(alignment: Alignment.bottomRight, child: viewMoreButton()),
            CarouselIndicator(
                controller: controller,
                count: widget.barterItem.imageUrls.length),
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
      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 25),
      child: SizedBox.expand(
        child: Column(
          children: [
            Flexible(child: overlayBuilder(itemDetails())),
          ],
        ),
      ),
    );
  }

  Widget itemDetails() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(15)),
        child: const Padding(
          padding: EdgeInsets.all(17),
          child: Text(
            descriptionText,
            overflow: TextOverflow.ellipsis,
            maxLines: 17,
            style: TextStyle(color: Colors.black87, height: 1.4),
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
        border: Border.all(color: Colors.grey.shade300, width: 0.5));
  }

  Widget tags() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
      child: TagsWidget(tags: widget.barterItem.tags),
    );
  }
}
