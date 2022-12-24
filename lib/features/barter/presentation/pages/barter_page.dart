// ignore_for_file: must_call_super

import 'package:bidex/common/widgets/loading_page.dart';
import 'package:bidex/features/barter/presentation/widgets/barter_item_widget.dart';
import 'package:flutter/material.dart';

class BarterPage extends StatefulWidget {
  const BarterPage({Key? key}) : super(key: key);

  @override
  createState() => _BarterPage();
}

class _BarterPage extends State<BarterPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // LoadingPage(loading: false),
          body(),
        ],
      ),
    );
  }

  Widget body() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemBuilder: (context, index) => const BarterItemWidget(),
      itemCount: 5,
    );
  }
}
