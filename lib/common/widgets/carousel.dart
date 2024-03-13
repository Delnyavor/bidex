import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class Carousel extends StatefulWidget {
  final EdgeInsets margin;
  final double radius;
  final List<String> images;
  final PageController controller;
  const Carousel(
      {super.key,
      required this.images,
      required this.controller,
      this.radius = 0.0,
      this.margin = EdgeInsets.zero});

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius),
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: path,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
