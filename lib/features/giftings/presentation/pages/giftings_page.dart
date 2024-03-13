// ignore_for_file: must_call_super

import 'package:bidex/features/giftings/presentation/bloc/giftings_bloc.dart';
import 'package:bidex/features/giftings/presentation/widgets/giftings_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/loading_page.dart';
import 'gift_page.dart';

class GiftingsPage extends StatefulWidget {
  const GiftingsPage({super.key});

  @override
  State<GiftingsPage> createState() => _GiftingsPageState();
}

class _GiftingsPageState extends State<GiftingsPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late GiftingsBloc bloc;
  late AnimationController controller;
  ScrollController scrollController = ScrollController();
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    scrollController.addListener(scrollListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    bloc = BlocProvider.of<GiftingsBloc>(context);
    bloc.add(const FetchGiftsEvent());
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(scrollListener)
      ..dispose();
    super.dispose();
  }

  void scrollListener() {
    if (_isBottom) {
      bloc.add(const FetchGiftsEvent());
    }
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll - 45);
  }

  void stateListener(GiftingsState state) {
    if (state.giftingsPageStatus != GiftingsPageStatus.loading) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocListener<GiftingsBloc, GiftingsState>(
        listener: (context, state) {
          stateListener(state);
        },
        child: buildStack(),
      ),
    );
  }

  Widget buildStack() {
    return Stack(
      children: [body(), LoadingPage(controller: controller)],
    );
  }

  Widget body() {
    return BlocBuilder<GiftingsBloc, GiftingsState>(
      bloc: bloc,
      builder: (context, state) {
        return ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(vertical: 20),
          itemBuilder: (context, index) {
            return index >= state.items.length
                ? bottomLoader()
                : GiftItemWidget(
                    item: state.items[index],
                  );
          },
          itemCount:
              state.hasReachedMax ? state.items.length : state.items.length + 1,
        );
      },
    );
  }

  Widget bottomLoader() {
    return const SizedBox(
      height: 40,
      width: 40,
      child: Center(
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(strokeWidth: 1.5),
        ),
      ),
    );
  }
}
