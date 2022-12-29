// ignore_for_file: must_call_super

import 'package:bidex/common/widgets/loading_page.dart';
import 'package:bidex/features/barter/presentation/widgets/barter_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc/barter_bloc.dart';

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

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  int counter = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    bloc = BlocProvider.of(context);
    bloc.add(const FetchBarterItems());
  }

  void listen(BarterState state) {
    print(counter);

    if (state.barterPageStatus != BarterPageStatus.loading) {
      ++counter;
      controller.forward();
    } else {
      ++counter;
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocListener<BarterBloc, BarterState>(
        listener: (context, state) {
          listen(state);
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
          padding: const EdgeInsets.symmetric(vertical: 20),
          itemBuilder: (context, index) => BarterItemWidget(
            barterItem: state.items[index],
          ),
          itemCount: state.items.length,
        );
      },
    );
  }
}
