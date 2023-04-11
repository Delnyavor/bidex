import 'package:bidex/common/app_colors.dart';
import 'package:bidex/common/widgets/carousel.dart';
import 'package:bidex/common/widgets/navbar/nav_action_button.dart';
import 'package:bidex/features/auction/presentation/widgets/auction_details.dart';
import 'package:bidex/features/auction/presentation/widgets/bid_count.dart';
import 'package:bidex/features/auction/presentation/widgets/bottom_nav_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/transitions/route_transitions.dart';
import '../../../../common/widgets/carousel_indicator.dart';
import '../../../../common/widgets/translucent_app_bar.dart';
import '../../../direct_messages/presentation/pages/direct_messages_page.dart';

class BiddingPage extends StatefulWidget {
  const BiddingPage({Key? key}) : super(key: key);

  @override
  State<BiddingPage> createState() => _BiddingPageState();
}

class _BiddingPageState extends State<BiddingPage>
    with TickerProviderStateMixin {
  late TabController controller;

  PageController pageController = PageController();
  bool showFirst = true;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.translucentStatusAppBar,
      body: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            systemOverlayStyle:
                CustomAppBar.translucentStatusAppBar.systemOverlayStyle,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            leading: leading(),
            title: title(),
            actions: actions(),
          ),
          body: body(),
          bottomNavigationBar: const BottomNavBidForm(),
          resizeToAvoidBottomInset: true),
    );
  }

  Widget leading() {
    return IconButton(
      onPressed: () {
        // if (widget.implyLeading) {
        Navigator.pop(context);
      },
      icon: const Icon(
        // widget.implyLeading
        CupertinoIcons.chevron_back,
        // : CupertinoIcons.plus_square,
        size: 22,
      ),
    );
  }

  Widget title() {
    return Image.asset(
      'assets/images/logo.png',
      height: 100,
    );
  }

  List<Widget> actions() {
    return [
      chatButton(),
      search(),
    ];
  }

  Widget chatButton() {
    return NavAction(
      onPressed: () {
        Navigator.push(
          context,
          slideInRoute(const DirectMessagesPage()),
        );
      },
      child: const Icon(
        CupertinoIcons.chat_bubble_2,
        size: 22,
      ),
    );
  }

  Widget search() {
    return NavAction(
      onPressed: () {},
      child: const Icon(
        CupertinoIcons.search,
        size: 22,
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          image(),
          tabs(),
          views(),
        ],
      ),
    );
  }

  Widget image() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          const BoxShadow(
            color: Colors.black38,
            spreadRadius: -1,
            blurRadius: 1,
            offset: Offset(0, 0.5),
          ),
          BoxShadow(
            color: Colors.black12.withOpacity(0.6),
            spreadRadius: -5,
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Carousel(
                controller: pageController,
                images: [
                  'stock2.jpg',
                  'stock3.jpg',
                  'stock1.jpg',
                  'stock0.jpg',
                ],
              ),
              CarouselIndicator(controller: pageController, count: 4)
            ],
          ),
        ),
      ),
    );
  }

  Widget tabs() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(18),
      ),
      child: TabBar(
        controller: controller,
        tabs: const [
          Tab(text: 'Details', height: 35),
          Tab(text: 'Bid', height: 35),
        ],
        unselectedLabelColor: AppColors.darkBlue,
        indicator: BoxDecoration(
          color: AppColors.darkBlue,
          borderRadius: BorderRadius.circular(18),
        ),
        onTap: (index) {
          if (index == 0) {
            setState(() {
              showFirst = true;
            });
          } else {
            setState(() {
              showFirst = false;
            });
          }
        },
      ),
    );
  }

  Widget views() {
    return showFirst ? const AuctionDetailsWidget() : const BidCount();
  }
}
