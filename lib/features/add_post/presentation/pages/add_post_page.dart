import 'package:bidex/features/add_post/presentation/pages/create_auction_page.dart';
import 'package:bidex/features/add_post/presentation/pages/create_gift_page.dart';
import 'package:bidex/features/add_post/presentation/pages/sections/add_auction_section.dart';
import 'package:bidex/features/add_post/presentation/pages/sections/add_barter_section.dart';
import 'package:bidex/features/add_post/presentation/pages/sections/create_barter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/create_post_bloc.dart';

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

  int page = 0;

  List<Widget> pages = const [
    CreateGiftPage(),
    CreateAuctionPage(),
    CreateBarterPage(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<CreatePostBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: buildPage(),
    );
  }

  Widget buildPage() {
    return BlocListener<CreatePostBloc, CreatePostState>(
      bloc: bloc,
      listener: (context, state) {
        if (state.page != page) {
          setState(() {
            page = state.page;
          });
        }
      },
      child: IndexedStack(
        index: page,
        children: pages,
      ),
    );
  }
}
