import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  final EdgeInsets margin;
  final double radius;
  final List<String> images;
  final PageController controller;
  const Carousel(
      {Key? key,
      required this.images,
      required this.controller,
      this.radius = 0.0,
      this.margin = EdgeInsets.zero})
      : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: widget.controller,
      children: widget.images.map((e) => child(e)).toList(),
    );
  }

  Widget child(String path) {
    return Padding(
      padding: widget.margin,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              path,
            ),
          ),
        ),
      ),
    );
  }
}
