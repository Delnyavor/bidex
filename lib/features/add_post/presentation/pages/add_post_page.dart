import 'package:bidex/common/transitions/route_transitions.dart';
import 'package:bidex/features/add_post/presentation/pages/sections/add_auction_section.dart';
import 'package:bidex/features/add_post/presentation/pages/sections/add_barter_section.dart';
import 'package:bidex/features/add_post/presentation/pages/sections/add_gift_section.dart';
import 'package:bidex/features/auction/domain/entities/auction_item.dart';
import 'package:bidex/features/auction/presentation/pages/bidding_page.dart';
import 'package:bidex/features/barter/presentation/pages/barter_page.dart';
import 'package:bidex/features/giftings/presentation/pages/gift_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/modal_form/button_cancel.dart';
import '../../../../common/widgets/modal_form/button_proceed.dart';
import '../../../barter/domain/entities/barter_item.dart';
import '../../../home/presentation/widgets/global_app_bar.dart';
import '../../../scaffolding/scaffold.dart';
import '../bloc/create_post_bloc.dart';
import '../widgets/post_type_selector.dart';

class AddPostPage extends StatefulWidget {
  final dynamic post;
  const AddPostPage({
    super.key,
    this.post,
  });

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

  late bool isEditing;

  late AnimationController controller;
  late Animation<double> animation;

  void viewEditedPost() {
    late Widget route;

    if (widget.post is AuctionItem) {
      route = const BiddingPage();
    } else if (widget.post is BarterItem) {
      route = const BarterPage();
    } else {
      route = const GiftPage();
    }

    Navigator.pushReplacement(context, slideInRoute(route));
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    animation = Tween<double>(begin: 0.3, end: 1).animate(controller);

    isEditing = widget.post != null;
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
                  child: widget.post == null ? buildPage() : buildEditingPage(),
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
    return BlocListener<CreatePostBloc, CreatePostState>(
      listener: (BuildContext context, state) {
        if (state.pageStatus == CreatePostPageStatus.successful) {
          if (widget.post != null) {
            viewEditedPost();
          } else {
            Navigator.pop(context);
          }
          bloc.add(const InitialiseCreatePost());
        }
      },
      child: BlocBuilder<CreatePostBloc, CreatePostState>(
        bloc: bloc,
        buildWhen: (previous, current) => current != previous,
        builder: (context, state) {
          return IndexedStack(
            index: state.page,
            children: pages,
          );
        },
      ),
    );
  }

  Widget buildEditingPage() {
    if (widget.post is AuctionItem) {
      return AddAuctionSection(item: widget.post);
    } else if (widget.post is BarterItem) {
      return const AddBarterSection();
    } else {
      return const AddGiftSection();
    }
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
