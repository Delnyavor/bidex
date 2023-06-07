import 'package:bidex/common/app_colors.dart';
import 'package:flutter/material.dart';

class CarouselIndicator extends StatefulWidget {
  final PageController controller;
  final int count;
  final double luminance;
  final bool expandIndex;
  final double? width;
  final double? spacing;
  final EdgeInsets? padding;
  const CarouselIndicator({
    Key? key,
    required this.controller,
    required this.count,
    this.luminance = 0,
    this.expandIndex = true,
    this.width,
    this.spacing,
    this.padding,
  }) : super(key: key);

  @override
  State<CarouselIndicator> createState() => _CarouselIndicatorState();
}

class _CarouselIndicatorState extends State<CarouselIndicator> {
  int currentIndex = 0;
  double defaultWidth = 5;
  late double defaultSpacing;

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
        padding: widget.padding ?? const EdgeInsets.all(20),
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
      padding: EdgeInsets.symmetric(
          horizontal: widget.spacing ?? (defaultWidth * 0.7)),
      child: AnimatedContainer(
        decoration: BoxDecoration(
          // boxShadow: shadowBuilder(),
          color: currentIndex == index
              ? activeColorBuilder()
              : inactiveColorBuilder(),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black.withOpacity(0.1), width: 0.1),
        ),
        duration: const Duration(milliseconds: 150),
        height: widget.width ?? defaultWidth,
        width: indexWidthBuilder(index),
      ),
    );
  }

  double indexWidthBuilder(int index) {
    if (currentIndex == index) {
      if (widget.expandIndex) {
        return (widget.width ?? defaultWidth) * 2.6;
      }
    }
    return widget.width ?? defaultWidth;
  }

  Color activeColorBuilder() {
    return (widget.luminance > 0.5) ? AppColors.blue : Colors.white;
  }

  Color inactiveColorBuilder() {
    return (widget.luminance > 0.5)
        ? AppColors.inactiveGrey
        : Colors.white.withOpacity(0.6);
  }

  List<BoxShadow>? shadowBuilder() {
    return (widget.luminance > 0.5)
        ? const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.5, 0.5),
              blurRadius: 0,
            )
          ]
        : null;
  }
}
