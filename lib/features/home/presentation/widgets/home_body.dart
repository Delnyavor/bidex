import 'package:bidex/features/auction/presentation/pages/auction_page.dart';
import 'package:bidex/features/barter/presentation/pages/barter_page.dart';
import 'package:bidex/features/home/presentation/bloc/navigation_bloc.dart/bloc/navigation_bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../giftings/presentation/pages/giftings_page.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody>
    with SingleTickerProviderStateMixin {
  final duration = 100;

  late AnimationController controller;
  late PageController pageController;
  late Animation<double> fadeInOut;
  late NavigationBloc bloc;
  List<Widget> pages = const [
    BarterPage(),
    AuctionsPage(),
    GiftingsPage(),
    Center(
      child: Icon(CupertinoIcons.person_alt_circle),
    )
  ];
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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<NavigationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
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
}
