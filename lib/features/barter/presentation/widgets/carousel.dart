import 'package:bidex/common/widgets/image.dart';
import 'package:bidex/features/barter/presentation/widgets/carousel_indicator.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

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
          itemBuilder: (context, index) => child(),
          itemCount: 5,
        ),
        CarouselIndicator(
          controller: controller,
          count: 5,
        )
      ],
    );
  }

  Widget child() {
    return const DisplayImage(
      path: 'assets/images/stock2.jpg',
      height: 500,
      width: 700,
    );
  }
}
