import 'package:bidex/common/widgets/modal_form/bottom_modal.dart';
import 'package:bidex/features/auction/presentation/widgets/verification_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/loading_page.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/auction_bloc.dart';
import '../widgets/auction_widget.dart';

class AuctionsPage extends StatefulWidget {
  const AuctionsPage({Key? key}) : super(key: key);

  @override
  State<AuctionsPage> createState() => _AuctionsPageState();
}

class _AuctionsPageState extends State<AuctionsPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late AuctionBloc bloc;
  late AuthBloc authBloc;
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

    authBloc = BlocProvider.of<AuthBloc>(context);
    bloc = BlocProvider.of<AuctionBloc>(context);
    bloc.add(const FetchAuctionsEvent());
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
      bloc.add(const FetchAuctionsEvent());
    }
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll - 45);
  }

  void stateListener(AuctionState state) {
    if (state.auctionPageStatus != AuctionPageStatus.loading) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  void onTap(int id) {
    // jumpToPage(1);
    checkIsVerified();
    // bloc.add(FetchAuctionEvent(id: id));
  }

  void checkIsVerified() {
    // TODO: undo this
    // if (!authBloc.state.hasBeenVerified) {
    showFormDialog(context, const VerificationForm(), true);
    // }
  }

  void jumpToPage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocListener<AuctionBloc, AuctionState>(
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
    return BlocBuilder<AuctionBloc, AuctionState>(
      bloc: bloc,
      builder: (context, state) {
        return ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(vertical: 20),
          itemBuilder: (context, index) {
            return index >= state.items.length
                ? bottomLoader()
                : AuctionWidget(
                    auction: state.items[index],
                    ontap: () {
                      onTap(
                        state.items[index].id,
                      );
                    },
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
