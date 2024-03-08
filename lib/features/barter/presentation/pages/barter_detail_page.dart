import 'package:bidex/common/app_colors.dart';
import 'package:bidex/common/widgets/image.dart';
import 'package:bidex/features/barter/presentation/widgets/item_header.dart';
import 'package:bidex/features/comments/domain/entities/comment.dart';
import 'package:bidex/features/comments/presentation/bloc/comment_bloc.dart';
import 'package:bidex/features/comments/presentation/widgets/comment_list.dart';
import 'package:bidex/features/direct_messages/presentation/widgets/bottom_text_input.dart';
import 'package:bidex/features/profile/domain/entities/user_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../common/widgets/carousel.dart';
import '../../../../common/widgets/carousel_indicator.dart';
import '../../domain/entities/barter_item.dart';

class BarterDetailPage extends StatefulWidget {
  final BarterItem item;
  const BarterDetailPage({super.key, required this.item});

  @override
  State<BarterDetailPage> createState() => _BarterDetailPageState();
}

class _BarterDetailPageState extends State<BarterDetailPage>
    with SingleTickerProviderStateMixin {
  PageController controller = PageController();
  late TextEditingController textController;
  late CommentBloc commentBloc;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    commentBloc = BlocProvider.of<CommentBloc>(context);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.keyboard_arrow_left, size: 26),
        ),
        title: ItemHeader(
          item: widget.item,
          showLast: true,
        ),
        titleSpacing: 0,
        toolbarHeight: 70,
      ),
      body: body(),
      // bottomNavigationBar: inputBar(),
    );
  }

  Widget body() {
    return SlidingUpPanel(
      minHeight: 56,
      maxHeight: 500,
      backdropEnabled: true,
      body: background(),
      borderRadius: BorderRadius.circular(15),
      padding: const EdgeInsets.all(0),
      panel: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.05))),
            child: title('Comments'),
          ),
        ),
        body: CommentList(
          postId: widget.item.id,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        ),
        bottomNavigationBar: inputBar(),
        resizeToAvoidBottomInset: true,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: -8,
          blurRadius: 12,
        )
      ],
    );
  }

  Widget background() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          carousel(),
          title('Details'),
          description(),
        ],
      ),
    );
  }

  Widget carousel() {
    return AspectRatio(
      aspectRatio: 1.4,
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

  Widget title(String text, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: color ?? Colors.black.withOpacity(0.75),
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget description() {
    return Text(
      widget.item.description,
      overflow: TextOverflow.ellipsis,
      maxLines: 16,
      style: const TextStyle(
        color: Colors.black87,
        letterSpacing: 0,
      ),
    );
  }

  Widget inputBar() {
    return Container(
      color: Colors.grey.shade100,
      child: DMInput(
        onSubmit: () {
          commentBloc.add(
            CreateComment(
              Comment(
                content: textController.text,
                userId: widget.item.userId,
                postId: widget.item.id,
                type: PostType.barter.name,
              ),
            ),
          );

          textController.clear();
        },
        controller: textController,
      ),
    );
  }
}
