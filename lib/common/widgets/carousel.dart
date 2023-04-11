import 'package:bidex/common/widgets/image.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  final List<String> images;
  final PageController controller;
  const Carousel({Key? key, required this.images, required this.controller})
      : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.controller,
      itemBuilder: (context, index) => child(widget.images[index]),
      itemCount: widget.images.length,
    );
  }

  Widget child(String path) {
    return DisplayImage(
      // TODO: make this a clean url
      path: 'assets/images/$path',
      height: 675,
      width: 676,
    );
  }
}
