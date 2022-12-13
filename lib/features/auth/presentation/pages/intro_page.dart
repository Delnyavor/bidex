import 'package:bidex/common/app_colors.dart';
import 'package:bidex/common/transitions/scroll_behaviour.dart';
import 'package:bidex/common/widgets/page_indicator.dart';
import 'package:bidex/common/widgets/translucent_app_bar.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.translucentStatusAppBar,
      body: SafeArea(child: body()),
    );
  }

  Widget body() {
    return Column(
      children: [
        pageView(),
        text(),
      ],
    );
  }

  Widget pageView() {
    return Flexible(
      flex: 1,
      child: ScrollConfiguration(
        behavior: NoOverScrollGlowBehavior(),
        child: PageView(
          scrollBehavior: NoOverScrollGlowBehavior(),
          children: [
            infoPage(),
            infoPage(),
            infoPage(),
          ],
        ),
      ),
    );
  }

  Widget infoPage() {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.darkBlue,
          borderRadius: BorderRadius.circular(24),
          // image: DecorationImage(image: FileImage(imageData!), fit: BoxFit.cover),
        ),
        // child: AspectRatio(aspectRatio: 1),
      ),
    );
  }

  Widget indicators() {
    return PageIndicatorWidget(controller: controller, length: 3);
  }

  Widget text() {
    return Expanded(
      child: Column(
        children: [
          headline(context),
          subText(),
        ],
      ),
    );
  }

  Widget headline(context) {
    return Text(
      'Trade Everything',
      style: Theme.of(context).textTheme.headline4!.copyWith(
            color: AppColors.darkBlue,
            fontWeight: FontWeight.bold,
            height: 1.5,
          ),
    );
  }

  Widget subText() {
    return const Text(
      '''Lorem ipsum dolor sit amet, consectetur adipiscing elit.
Nullam a dolor vel massa Lorem ipsum dolorsit amet, consectetura dipiscing elit. ''',
      textAlign: TextAlign.center,
      style: TextStyle(height: 1.5),
    );
  }
}
