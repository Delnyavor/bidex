import 'package:bidex/features/add_post/presentation/pages/sections/add_auction_section.dart';
import 'package:bidex/features/add_post/presentation/pages/sections/add_barter_section.dart';
import 'package:bidex/features/add_post/presentation/pages/sections/add_gift_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/modal_form/button_cancel.dart';
import '../../../../common/widgets/modal_form/button_proceed.dart';
import '../../../home/presentation/widgets/global_app_bar.dart';
import '../../../scaffolding/scaffold.dart';
import '../bloc/create_post_bloc.dart';
import '../widgets/post_type_selector.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  createState() => _AddPostPage();
}

class _AddPostPage extends State<AddPostPage> with TickerProviderStateMixin {
  late CreatePostBloc bloc;
  GlobalKey parentKey = GlobalKey();
  LayerLink layerLink = LayerLink();
  OverlayEntry? entry;

  List<Widget> pages = const [
    AddGiftSection(),
    AddAuctionSection(),
    AddBarterSection(),
  ];

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    animation = Tween<double>(begin: 0.3, end: 1).animate(controller);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<CreatePostBloc>(context);
  }

  @override
  void dispose() {
    controller.dispose();
    disposeEntry();
    super.dispose();
  }

  void disposeEntry() async {
    if (entry != null) {
      if (entry!.mounted) {
        entry!.remove();
      }
      entry!.dispose();
    }
  }

  OverlayEntry? buildEntry() {
    RenderBox? renderBox =
        parentKey.currentContext!.findRenderObject() as RenderBox;

    Offset parentOffset = renderBox.localToGlobal(Offset.zero);

    entry = OverlayEntry(builder: (context) {
      return Stack(
        children: [
          Positioned(
            top: parentOffset.dy,
            left: parentOffset.dx,
            child: CompositedTransformFollower(
              link: layerLink,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) => FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                  child: Container(
                    color: Colors.grey.withOpacity(0.5),
                    height: renderBox.size.height,
                    width: renderBox.size.width,
                    child: const Center(
                        child: CircularProgressIndicator.adaptive()),
                  ),
                  // ),
                ),
              ),
            ),
          ),
        ],
      );
    });

    return entry;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffolding(
      appBar: const GlobalAppBar(),
      body: CompositedTransformTarget(
        link: layerLink,
        child: Padding(
          key: parentKey,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: PostTypeSelector(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: buildPage(),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavbar: bottom(),
    );
  }

  Widget buildPage() {
    return BlocBuilder<CreatePostBloc, CreatePostState>(
      bloc: bloc,
      buildWhen: (previous, current) => current != previous,
      builder: (context, state) {
        return IndexedStack(
          index: state.page,
          children: pages,
        );
      },
    );
  }

  Widget bottom() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CancelButton(text: 'CANCEL'),
          ProceedButton(
            text: 'ADD',
            onPressed: () {
              bloc.add(const SubmitPost());
              // TODO: block interactivity duting submission
              // Overlay.of(context).insert(buildEntry()!);
              // controller.forward();
            },
          )
        ],
      ),
    );
  }
}
