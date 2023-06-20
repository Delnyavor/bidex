import 'package:bidex/common/transitions/route_transitions.dart';
import 'package:bidex/common/widgets/carousel_indicator.dart';
import 'package:bidex/features/barter/domain/entities/barter_item.dart';
import 'package:bidex/common/widgets/carousel.dart';
import 'package:bidex/common/widgets/tags_widget.dart';
import 'package:bidex/features/barter/presentation/pages/barter_details_page.dart';
import 'package:flutter/material.dart';

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
  Duration duration = const Duration(milliseconds: 120);
  bool isOpen = false;

  void viewMore() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, slideInRoute(BarterDetailsPage(item: widget.barterItem)));
      },
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
            CarouselIndicator(
                controller: controller,
                count: widget.barterItem.imageUrls.length),
            detailsBuilder(),
            Align(
              alignment: Alignment.bottomRight,
              child: viewMoreButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailsBuilder() {
    return AnimatedScale(
      scale: isOpen ? 1 : 0.95,
      curve: Curves.fastLinearToSlowEaseIn,
      duration: duration,
      child: AnimatedOpacity(
        opacity: isOpen ? 1 : 0,
        duration: duration,
        child: itemDetails(),
      ),
    );
  }

  Widget itemDetails() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 55),
      // width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.6),
        ),
        child: const Padding(
          padding: EdgeInsets.all(17),
          child: Text(
            '''Custom gaming pc build i like to call the blue dragon. It runs on 2 RTX 3090 cards for graphics and an Intel i9 508820HK for Logic.
Predominantly blue configuration for RGB lights(hence the name), optional Liquid cooling and more ports than you could possibly need. Full Specs below.

Height: 8.36” | 21.24 cm
Width: 11.97” | 30.41 cm
Depth: .61” | 1.56 cm
Screen Size: 13.3”
Resolution:2560 x 1600, 227 ppi
Weight:2.75 lb | 1.25 kg Condition: New

 Im looking for the listed items alright but if you have anything of comparable value lets talk
 
Height: 8.36” | 21.24 cm
Width: 11.97” | 30.41 cm
Depth: .61” | 1.56 cm
Screen Size: 13.3”
Resolution:2560 x 1600, 227 ppi
Weight:2.75 lb | 1.25 kg Condition: New

Im looking for the listed items alright but if you have anything of comparable value lets talk''',
            overflow: TextOverflow.ellipsis,
            maxLines: 16,
            style: TextStyle(color: Colors.black87),
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
        child: IconButton(
          onPressed: viewMore,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minHeight: 33, minWidth: 33),
          icon: isOpen
              ? const Icon(Icons.keyboard_arrow_down)
              : const Icon(Icons.menu),
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
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300, width: 0.5)
        // boxShadow: [
        //   const BoxShadow(
        //     color: Colors.black38,
        //     spreadRadius: -1,
        //     blurRadius: 1,
        //     offset: Offset(0, 0.5),
        //   ),
        //   BoxShadow(
        //     color: Colors.black12.withOpacity(0.2),
        //     spreadRadius: -5,
        //     blurRadius: 8,
        //     offset: Offset(0, 1),
        //   ),
        // ],
        );
  }

  Widget tags() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
      child: TagsWidget(tags: widget.barterItem.tags),
    );
  }
}
