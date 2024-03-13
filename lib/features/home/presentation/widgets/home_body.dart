import 'package:bidex/features/auction/presentation/pages/auction_page.dart';
import 'package:bidex/features/barter/presentation/pages/barter_page.dart';
import 'package:bidex/features/home/presentation/bloc/navigation_bloc.dart/bloc/navigation_bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../giftings/presentation/pages/giftings_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

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
    ProfilePage(),
  ];
  int position = 0;

  @override
  void dispose() {
    pageController.dispose();
    controller.dispose();
    super.dispose();
  }

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
    position = bloc.state.page;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state.page != position) {
          setState(() {
            position = state.page;
          });
        }
      },
      child: IndexedStack(
        index: position,
        children: pages,
      ),
    );
  }
}
