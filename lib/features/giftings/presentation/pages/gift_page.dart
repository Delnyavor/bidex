import 'package:bidex/common/widgets/image.dart';
import 'package:bidex/common/widgets/carousel.dart';
import 'package:bidex/features/giftings/presentation/bloc/giftings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/carousel_indicator.dart';
import '../../domain/entities/gift_item.dart';

class GiftPage extends StatefulWidget {
  const GiftPage({Key? key}) : super(key: key);

  @override
  State<GiftPage> createState() => _GiftPageState();
}

class _GiftPageState extends State<GiftPage> {
  late GiftingsBloc bloc;
  PageController controller = PageController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<GiftingsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GiftingsBloc, GiftingsState>(
        builder: (context, state) {
          if (state.giftPageStatus == GiftingsPageStatus.giftLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (state.giftPageStatus == GiftingsPageStatus.giftLoaded) {
              if (state.item != null) {
                return GiftDisplay(
                  gift: state.item!,
                  controller: controller,
                );
              }
            }
          }
          return Container(
            color: Colors.red,
          );
        },
      ),
    );
  }
}

class GiftDisplay extends StatelessWidget {
  final Gift gift;
  final PageController controller;
  const GiftDisplay({
    Key? key,
    required this.gift,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        profile(),
        const SizedBox(height: 8),
        userdetails(context),
        const SizedBox(height: 20),
        itemTitle(context),
        const SizedBox(height: 6),
        slideshow(),
        description(context),
      ],
    );
  }

  Widget slideshow() {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            Carousel(
              images: gift.imageUrls,
              controller: controller,
            ),
            CarouselIndicator(
              controller: controller,
              count: gift.imageUrls.length,
            )
          ],
        ),
      ),
    );
  }

  Widget profile() {
    return const CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage(
        'assets/images/prof.jpg',
      ),
    );
  }

  Widget userdetails(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Nii Kpapo',
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          'Labone, accra',
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Colors.black54,
              ),
        )
      ],
    );
  }

  Widget itemTitle(BuildContext context) {
    return Text(
      'Custom built desktop',
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
    );
  }

  Widget description(BuildContext context) {
    return Text(
      'description',
      style: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: Colors.black87,
          ),
    );
  }
}
