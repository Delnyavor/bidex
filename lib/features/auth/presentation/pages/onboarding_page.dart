import 'package:bidex/common/app_colors.dart';
import 'package:bidex/common/widgets/translucent_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/carousel.dart';
import '../../../../common/widgets/carousel_indicator.dart';
import '../widgets/auth_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  createState() => _OnboardingPage();
}

class _OnboardingPage extends State<OnboardingPage> {
  final PageController controller = PageController();
  final List<String> images = [
    'cashback.jpg',
    'lending.jpg',
    'reseller.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.translucentStatusAppBar,
      backgroundColor: AppColors.lightBlue,
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          carousel(),
          indicator(),
          title(),
          description(),
          button(),
          signIn(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget carousel() {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Carousel(
        images: images,
        controller: controller,
        radius: 15,
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      ),
    );
  }

  Widget indicator() {
    return CarouselIndicator(
      controller: controller,
      count: images.length,
      luminance: AppColors.lightBlue.computeLuminance(),
      expandIndex: false,
      width: 7,
      padding: const EdgeInsets.symmetric(vertical: 25),
      spacing: 7,
    );
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: Text(
        'Trade Everything!',
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: AppColors.darkBlue,
              fontWeight: FontWeight.w900,
              fontSize: 30,
            ),
      ),
    );
  }

  Widget description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        'Lipsum dolor sit amet consecutur alispem. Lipsum dolor sit amet consecutur alispem. Lipsum dolor sit amet consecutur alispem. Lipsum dolor sit amet consecutur alispem.',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.darkBlue, fontWeight: FontWeight.w900,
              height: 1.5,
              // fontSize: 32,
            ),
      ),
    );
  }

  Widget button() {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 15),
          child: AuthButton(
            label: 'Register',
            light: false,
            flex: true,
            onPressed: () {
              FocusScope.of(context).unfocus();
              // register();
            },
          ),
        ),
      ),
    );
  }

  Widget signIn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account? ',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: () {},
          child: const Text(
            'Sign In',
            style: TextStyle(
              color: AppColors.darkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
