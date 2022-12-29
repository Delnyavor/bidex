import 'package:bidex/common/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  final AnimationController controller;
  const LoadingPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  bool ignoring = true;
  late Animation<double> fadeIn;

  @override
  void initState() {
    super.initState();
    fadeIn = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0, 1, curve: Curves.fastOutSlowIn),
        reverseCurve: const Interval(0, 1, curve: Curves.easeInCubic),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loadingScreen();
  }

  Widget loadingScreen() {
    return AnimatedBuilder(
      animation: fadeIn,
      builder: (context, child) {
        return FadeTransition(opacity: fadeIn, child: loadingWidget());
      },
      // child: loadingWidget(),
    );
  }

  Widget loadingWidget() {
    return IgnorePointer(
      ignoring: widget.controller.isCompleted,
      child: SizedBox.expand(
        child: Container(
          color: AppColors.appWhite,
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
