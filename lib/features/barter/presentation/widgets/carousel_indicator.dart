import 'package:flutter/material.dart';

class CarouselIndicator extends StatefulWidget {
  final PageController controller;
  final int count;
  const CarouselIndicator(
      {Key? key, required this.controller, required this.count})
      : super(key: key);

  @override
  State<CarouselIndicator> createState() => _CarouselIndicatorState();
}

class _CarouselIndicatorState extends State<CarouselIndicator> {
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.page!.round() != currentIndex) {
        setState(() {
          currentIndex = widget.controller.page!.round();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.count,
            (index) => indicator(index),
          ),
        ),
      ),
    );
  }

  Widget indicator(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.5),
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: currentIndex == index
              ? Colors.white
              : Colors.yellow.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
        ),
        duration: const Duration(milliseconds: 150),
        height: currentIndex == index ? 9 : 5,
        width: currentIndex == index ? 9 : 5,
      ),
    );
  }
}
