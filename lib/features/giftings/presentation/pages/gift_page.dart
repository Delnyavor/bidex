import 'package:bidex/common/widgets/image.dart';
import 'package:bidex/common/widgets/carousel.dart';
import 'package:bidex/features/giftings/presentation/bloc/giftings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/gift_item.dart';

class GiftPage extends StatefulWidget {
  const GiftPage({Key? key}) : super(key: key);

  @override
  State<GiftPage> createState() => _GiftPageState();
}

class _GiftPageState extends State<GiftPage> {
  late GiftingsBloc bloc;

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
                return GiftDisplay(gift: state.item!);
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
  const GiftDisplay({
    Key? key,
    required this.gift,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        profile(),
        userdetails(context),
        itemTitle(context),
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
        child: Carousel(
          images: gift.imageUrls,
        ),
      ),
    );
  }

  Widget profile() {
    return const ClipRRect(
      child: AspectRatio(
        aspectRatio: 1,
        child: SizedBox(
          height: 60,
          width: 60,
          child: DisplayImage(
            height: 220,
            width: 180,
            path: 'assets/images/prof.jpg',
          ),
        ),
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
              ),
        ),
        Text(
          'labone, accra',
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Colors.black54,
              ),
        )
      ],
    );
  }

  Widget itemTitle(BuildContext context) {
    return Text(
      'custom built desktop',
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
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
