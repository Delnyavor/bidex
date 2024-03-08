import 'dart:ui';

import 'package:bidex/common/widgets/carousel_indicator.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../../../../common/utils/description_text.dart';
import '../../../../common/widgets/carousel.dart';
import '../../domain/entities/auction_item.dart';

class AuctionWidget extends StatefulWidget {
  final AuctionItem auction;
  final void Function()? ontap;
  const AuctionWidget({Key? key, required this.auction, this.ontap})
      : super(key: key);

  @override
  State<AuctionWidget> createState() => _AuctionWidgetState();
}

class _AuctionWidgetState extends State<AuctionWidget> {
  bool isOpen = false;
  Duration duration = const Duration(milliseconds: 100);

  void viewMore() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 24),
      decoration: decoration(),
      child: GestureDetector(
        onTap: widget.ontap,
        child: imageBackground(),
      ),
    );
  }

  Widget imageBackground() {
    return AspectRatio(
      aspectRatio: 0.85,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Carousel(
              controller: controller,
              images: widget.auction.images.map((e) => e.url!).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(child: overlayBuilder(itemDetails())),
                  CarouselIndicator(
                      controller: controller,
                      count: widget.auction.images.length),
                  infoBar(),
                ],
              ),
            ),
            viewMoreButton(),
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
        child: Container(color: Colors.white10),
      ),
    );
  }

  Widget itemDetails() {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(1),
          borderRadius: BorderRadius.circular(8)),
      child: const Padding(
        padding: EdgeInsets.all(17),
        child: Text(
          descriptionText,
          overflow: TextOverflow.ellipsis,
          maxLines: 12,
          style: TextStyle(color: Colors.black87, height: 1.4),
        ),
      ),
    );
  }

  Widget viewMoreButton() {
    return Positioned(
      right: 0,
      bottom: 10 + 60,
      child: Padding(
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
      ),
    );
  }

  Widget infoBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: 60,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 30),
          child: SizedBox.expand(
            child: Container(
              color: Colors.white12,
              child: controls(),
            ),
          ),
        ),
      ),
    );
  }

  Widget controls() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11.0, horizontal: 18),
      child: Row(
        children: [
          const Icon(CupertinoIcons.person_3_fill),
          const SizedBox(width: 5),
          const Text('15'),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('GHS 15,250',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  Text('GHS 10,000', style: TextStyle(fontSize: 10)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300, width: 0.5));
  }
}
