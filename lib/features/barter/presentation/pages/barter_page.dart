// ignore_for_file: must_call_super

import 'package:bidex/common/widgets/loading_page.dart';
import 'package:bidex/features/barter/presentation/widgets/barter_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/barter_bloc.dart';

class BarterPage extends StatefulWidget {
  const BarterPage({Key? key}) : super(key: key);

  @override
  createState() => _BarterPage();
}

class _BarterPage extends State<BarterPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  late BarterBloc bloc;
  late AnimationController controller;
  ScrollController scrollController = ScrollController();

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

    bloc = BlocProvider.of<BarterBloc>(context);
    bloc.add(const FetchBarterItems());
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
      bloc.add(const FetchBarterItems());
    }
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll - 45);
  }

  void stateListener(BarterState state) {
    if (state.barterPageStatus != BarterPageStatus.loading) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocListener<BarterBloc, BarterState>(
        listener: (context, state) {
          stateListener(state);
        },
        child: buildStack(),
      ),
    );
  }

  Widget buildStack() {
    return Stack(
      children: [
        body(),
        loadingBuilder(),
      ],
    );
  }

  Widget loadingBuilder() {
    return LoadingPage(controller: controller);
  }

  Widget body() {
    return BlocBuilder<BarterBloc, BarterState>(
      bloc: bloc,
      builder: (context, state) {
        return ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(vertical: 20),
          itemBuilder: (context, index) {
            return index >= state.items.length
                ? bottomLoader()
                : BarterItemWidget(
                    barterItem: state.items[index],
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
