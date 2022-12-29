import 'package:bidex/common/widgets/image.dart';
import 'package:bidex/features/barter/presentation/widgets/carousel_indicator.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  final List<String> images;
  const Carousel({Key? key, required this.images}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: controller,
          itemBuilder: (context, index) => child(widget.images[index]),
          itemCount: widget.images.length,
        ),
        CarouselIndicator(
          controller: controller,
          count: widget.images.length,
        )
      ],
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
