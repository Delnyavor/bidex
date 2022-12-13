import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  final bool loading;
  const LoadingPage({Key? key, required this.loading}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with TickerProviderStateMixin {
  bool ignoring = true;
  late AnimationController controller;
  late Animation<double> fadeIn;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.7, curve: Curves.fastOutSlowIn),
        reverseCurve: const Interval(0, 0.7, curve: Curves.easeInCubic),
      ),
    );

    runAnimation();
  }

  void runAnimation() {
    if (widget.loading == true) {
      if (!(controller.isAnimating || controller.isCompleted)) {
        setState(() {
          controller.forward();
        });
      }
    } else {
      if (!controller.isAnimating || controller.value != 0) {
        setState(() {
          controller.reverse();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return loadingScreen();
  }

  Widget loadingScreen() {
    return AnimatedBuilder(
      animation: fadeIn,
      builder: (context, child) {
        return FadeTransition(opacity: fadeIn, child: child!);
      },
      child: loadingWidget(),
    );
  }

  Widget loadingWidget() {
    return IgnorePointer(
      ignoring: ignoring,
      child: SizedBox.expand(
        child: Container(
          color: Colors.grey[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                height: 50,
                width: 50,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              Text(
                'Just a minute',
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
