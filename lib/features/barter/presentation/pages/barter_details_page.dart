import 'package:bidex/common/widgets/image.dart';
import 'package:bidex/features/comments/domain/entities/comment.dart';
import 'package:bidex/features/comments/presentation/bloc/comment_bloc.dart';
import 'package:bidex/features/comments/presentation/widgets/comment_list.dart';
import 'package:bidex/features/direct_messages/presentation/widgets/bottom_text_input.dart';
import 'package:bidex/features/profile/domain/entities/user_post.dart';
import 'package:bidex/features/scaffolding/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/carousel.dart';
import '../../../../common/widgets/carousel_indicator.dart';
import '../../../../common/widgets/tabs.dart';
import '../../../home/presentation/widgets/global_app_bar.dart';
import '../../domain/entities/barter_item.dart';

class BarterDetailsPage extends StatefulWidget {
  final BarterItem item;
  const BarterDetailsPage({super.key, required this.item});

  @override
  State<BarterDetailsPage> createState() => _BarterDetailsPageState();
}

class _BarterDetailsPageState extends State<BarterDetailsPage>
    with SingleTickerProviderStateMixin {
  PageController controller = PageController();
  bool isPageFirst = true;
  late TabController tabController;
  late TextEditingController textController;
  late CommentBloc commentBloc;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    textController = TextEditingController();

    commentBloc = BlocProvider.of<CommentBloc>(context);
  }

  void changePage(int index) {
    setState(() {
      if (index == 0) {
        isPageFirst = true;
        textController.clear();
      } else {
        isPageFirst = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffolding(
      appBar: GlobalAppBar(
        implyLeading: true,
        title: title(),
        // title: ItemHeader(
        //   barterItem: widget.item,
        //   showLast: false,
        // ),
      ),
      body: body(),
      bottomNavbar: inputBar(),
      resizeToAvoidInsets: true,
    );
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: const DisplayImage(
              path: 'assets/images/stock0.jpg',
              height: 35,
              width: 35,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.id,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                ),
                Text(
                  widget.item.location,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.black87,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          carousel(),
          tabs(),
          views(),
        ],
      ),
    );
  }

  Widget carousel() {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Carousel(
              images: widget.item.images.map((e) => e.url!).toList(),
              controller: controller,
            ),
            CarouselIndicator(
                controller: controller, count: widget.item.images.length),
          ],
        ),
      ),
    );
  }

  Widget tabs() {
    return Tabs(
      controller: tabController,
      labels: const ["Details", "Comments"],
      onTap: (index) {
        changePage(index);
      },
    );
  }

  Widget views() {
    return IndexedStack(
      index: tabController.index,
      children: [
        description(),
        CommentList(
          postId: widget.item.id,
        )
      ],
    );
  }

  Widget description() {
    return Text(
      widget.item.description,
      overflow: TextOverflow.ellipsis,
      maxLines: 16,
      style: const TextStyle(color: Colors.black87, letterSpacing: 0),
    );
  }

  Widget inputBar() {
    return IgnorePointer(
      ignoring: isPageFirst,
      child: DMInput(
        controller: textController,
        preventFocus: isPageFirst,
        onSubmit: () {
          //   commentBloc.add(
          //     CreateComment(
          //       Comment(
          //         content: textController.text,
          //         userId: widget.item.userId,
          //         postId: widget.item.id,
          //         type: PostType.barter.toString(),
          //       ),
          //     ),
          //   );

          // print(PostType.barter.toString());
        },
      ),
    );
  }
}
