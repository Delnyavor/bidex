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

class _BarterPage extends State<BarterPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool loading = true;

  void listen(BarterState state) {
    setState(() {
      if (state.barterPageStatus == BarterPageStatus.loading) {
      } else {
        loading = false;
      }
    });
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
        LoadingPage(loading: loading),
        body(),
      ],
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
