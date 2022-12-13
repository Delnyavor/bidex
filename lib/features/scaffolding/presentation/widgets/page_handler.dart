import 'package:bidex/features/scaffolding/presentation/bloc/navigation_bloc.dart/bloc/navigation_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageHandler extends StatefulWidget {
  final List<Widget> pages;
  const PageHandler({Key? key, required this.pages}) : super(key: key);

  @override
  State<PageHandler> createState() => _PageHandlerState();
}

class _PageHandlerState extends State<PageHandler>
    with SingleTickerProviderStateMixin {
  final duration = 100;

  late AnimationController controller;
  late PageController pageController;
  late Animation<double> fadeInOut;
  late Widget child;
  late NavigationBloc bloc;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: duration));
    fadeInOut = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.95, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<NavigationBloc>(context);
    child = widget.pages[bloc.state.page];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: decoration(),
        // child: builder()
        child: AnimatedBuilder(
          animation: fadeInOut,
          builder: (context, child) {
            return FadeTransition(
              opacity: fadeInOut,
              child: child,
            );
          },
          child: Center(
            child: builder(),
          ),
        ),
      ),
    );
  }

  Widget body() {
    return PageView(
      controller: pageController,
      children: widget.pages,
    );
  }

  Widget builder() {
    return BlocListener<NavigationBloc, NavigationState>(
        listener: (context, state) {
          controller.forward().whenComplete(() {
            setState(() {
              child = widget.pages[state.page];
            });
            controller.reverse();
          });
        },
        child: child
        // child: BlocBuilder<NavigationBloc, NavigationState>(
        //   builder: (context, state) {
        //     return widget.pages[state.page];
        //   },
        // ),
        );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(32),
      boxShadow: [
        const BoxShadow(
          color: Colors.black12,
          spreadRadius: -8,
          blurRadius: 5,
          offset: Offset(0, 0),
        ),
        BoxShadow(
          color: Colors.black12.withOpacity(0.1),
          spreadRadius: -3,
          blurRadius: 15,
          offset: Offset(0, 2),
        )
      ],
    );
  }
}
//   void listen(NavigatorState state){
//     if(state)
//   }
// }
