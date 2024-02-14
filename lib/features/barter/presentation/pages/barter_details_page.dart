import 'package:bidex/features/direct_messages/presentation/widgets/bottom_text_input.dart';
import 'package:bidex/features/scaffolding/scaffold.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/carousel.dart';
import '../../../../common/widgets/carousel_indicator.dart';
import '../../../../common/widgets/tabs.dart';
import '../../../home/presentation/widgets/global_app_bar.dart';
import '../../domain/entities/barter_item.dart';
import '../widgets/item_header.dart';

class BarterDetailsPage extends StatefulWidget {
  final BarterItem item;
  const BarterDetailsPage({super.key, required this.item});

  @override
  State<BarterDetailsPage> createState() => _BarterDetailsPageState();
}

class _BarterDetailsPageState extends State<BarterDetailsPage>
    with SingleTickerProviderStateMixin {
  PageController controller = PageController();
  bool isPageFirst = true;
  late TabController tabController;
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    textController = TextEditingController();
  }

  void changePage(int index) {
    setState(() {
      if (index == 0) {
        isPageFirst = true;
        textController.clear();
      } else {
        isPageFirst = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffolding(
      appBar: GlobalAppBar(
        implyLeading: true,
        title: ItemHeader(
          barterItem: widget.item,
          showLast: false,
        ),
      ),
      body: body(),
      bottomNavbar: inputBar(),
    );
  }

  Widget body() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        carousel(),
        tabs(),
        views(),
      ],
    );
  }

  Widget carousel() {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Carousel(
              images: widget.item.images.map((e) => e.url!).toList(),
              controller: controller,
            ),
            CarouselIndicator(
                controller: controller, count: widget.item.images.length),
          ],
        ),
      ),
    );
  }

  Widget tabs() {
    return Tabs(
      controller: tabController,
      labels: const ["Details", "Comments"],
      onTap: (index) {
        changePage(index);
      },
    );
  }

  Widget views() {
    return IndexedStack(
      index: tabController.index,
      children: [description(), Container()],
    );
  }

  Widget description() {
    return const Text(
      '''Custom gaming pc build i like to call the blue dragon. It runs on 2 RTX 3090 cards for graphics and an Intel i9 508820HK for Logic.
Predominantly blue configuration for RGB lights(hence the name), optional Liquid cooling and more ports than you could possibly need. Full Specs below.

Height: 8.36” | 21.24 cm
Width: 11.97” | 30.41 cm
Depth: .61” | 1.56 cm
Screen Size: 13.3”
Resolution:2560 x 1600, 227 ppi
Weight:2.75 lb | 1.25 kg Condition: New

 Im looking for the listed items alright but if you have anything of comparable value lets talk
 
Height: 8.36” | 21.24 cm
Width: 11.97” | 30.41 cm
Depth: .61” | 1.56 cm
Screen Size: 13.3”
Resolution:2560 x 1600, 227 ppi
Weight:2.75 lb | 1.25 kg Condition: New

Im looking for the listed items alright but if you have anything of comparable value lets talk''',
      overflow: TextOverflow.ellipsis,
      maxLines: 16,
      style: TextStyle(color: Colors.black87, letterSpacing: 0),
    );
  }

  Widget inputBar() {
    return IgnorePointer(
        ignoring: isPageFirst,
        child: DMInput(
          controller: textController,
          preventFocus: isPageFirst,
        ));
  }
}
