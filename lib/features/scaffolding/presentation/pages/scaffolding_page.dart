import 'package:bidex/common/widgets/translucent_app_bar.dart';
import 'package:bidex/features/scaffolding/presentation/widgets/global_app_bar.dart';
import 'package:bidex/features/scaffolding/presentation/widgets/global_bottom_bar.dart';
import 'package:bidex/features/scaffolding/presentation/widgets/page_handler.dart';
import 'package:flutter/material.dart';

class PageScaffolding extends StatefulWidget {
  const PageScaffolding({Key? key}) : super(key: key);

  @override
  createState() => _PageScaffolding();
}

class _PageScaffolding extends State<PageScaffolding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar.translucentStatusAppBar,
      body: body(),
      bottomNavigationBar: const GlobalBottomNavBar(),
    );
  }

  Widget body() {
    return SafeArea(
      child: Column(
        children: const [
          GlobalAppBar(),
          Flexible(
            child: PageHandler(),
          ),
        ],
      ),
    );
  }
}
