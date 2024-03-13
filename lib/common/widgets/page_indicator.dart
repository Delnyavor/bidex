import 'package:bidex/common/app_colors.dart';
import 'package:flutter/material.dart';

class PageIndicatorWidget extends StatefulWidget {
  final PageController controller;
  final int length;
  const PageIndicatorWidget(
      {super.key, required this.controller, required this.length});

  @override
  State<PageIndicatorWidget> createState() => _PageIndicatorWidgetState();
}

class _PageIndicatorWidgetState extends State<PageIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: generateChildren());
  }

  List<Widget> generateChildren() {
    List<Widget> list = [];
    for (int i = 0; i < widget.length; i++) {
      list.add(_Indicator(
          controller: widget.controller, position: i, key: Key(i.toString())));

      if (i + 1 != widget.length) {
        list.add(const SizedBox(
          width: 8,
        ));
      }
    }
    return list;
  }
}

class _Indicator extends StatefulWidget {
  final PageController controller;
  final int position;
  const _Indicator(
      {required super.key, required this.controller, required this.position});

  @override
  _IndicatorState createState() => _IndicatorState();
}

class _IndicatorState extends State<_Indicator> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation color;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    color = ColorTween(
            begin: AppColors.mutedBlue.withOpacity(0.15),
            end: AppColors.mutedBlue)
        .animate(controller);
    widget.controller.addListener(() {
      if (widget.controller.page!.round() == widget.position) {
        controller.forward();
      } else {
        controller.reverse();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.controller.page != null) {
      if (widget.position == widget.controller.page) {
        controller.forward();
      }
    } else {
      if (widget.position == 0) {
        controller.forward();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: color,
      builder: (context, child) => AnimatedContainer(
        duration: controller.duration!,
        height: 7,
        width: 7,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color.value,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
