import 'package:bidex/features/barter/presentation/pages/barter_page.dart';
import 'package:bidex/features/scaffolding/presentation/bloc/navigation_bloc.dart/bloc/navigation_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageHandler extends StatefulWidget {
  const PageHandler({Key? key}) : super(key: key);

  @override
  State<PageHandler> createState() => _PageHandlerState();
}

class _PageHandlerState extends State<PageHandler>
    with SingleTickerProviderStateMixin {
  final duration = 100;

  late AnimationController controller;
  late PageController pageController;
  late Animation<double> fadeInOut;
  late NavigationBloc bloc;
  List<Widget> pages = [];
  int position = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: duration,
      ),
    );
    fadeInOut = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.95, curve: Curves.easeIn),
      ),
    );

    pages = List.generate(3, (index) => card(index));
    pages.insert(0, const BarterPage());
    // child = pages[0];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<NavigationBloc>(context);
  }

  Widget card(int position) {
    return Card(
      child: Image.asset('assets/images/stock$position.jpg'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      decoration: decoration(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Center(
          child: builder(),
        ),
      ),
    );
  }

  Widget builder() {
    return BlocListener<NavigationBloc, NavigationState>(
      listener: (context, state) {
        pageController.jumpToPage(state.page);
      },
      child: PageView.builder(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, count) {
          return pages[count];
        },
        itemCount: pages.length,
      ),
    );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
      // color: Color(0xFFF9F9F9),
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: const [
        BoxShadow(
          spreadRadius: -5,
          blurRadius: 12,
          color: Colors.black26,
          offset: Offset(0, 2),
        ),
        BoxShadow(
          spreadRadius: 0,
          blurRadius: 1,
          color: Colors.black12,
          offset: Offset(0, 1),
        ),
      ],
    );
  }
}
