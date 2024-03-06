import 'package:bidex/features/comments/presentation/bloc/comment_bloc.dart';
import 'package:bidex/features/comments/presentation/widgets/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentList extends StatefulWidget {
  final String postId;
  final EdgeInsetsGeometry? padding;
  const CommentList({super.key, required this.postId, this.padding});

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  late CommentBloc bloc;
  ScrollController controller = ScrollController();
  final GlobalKey key = GlobalKey();

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<CommentBloc>(context);
    bloc.add(FetchComments(postId: widget.postId));
  }

  @override
  void dispose() {
    bloc.add(InitialiseComments());
    super.dispose();
  }

  bool shouldMoveToBottom = false;

  addListener() {
    controller.addListener(() {
      if (shouldMoveToBottom) {
        controller.jumpTo(controller.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state.commentsStatus == CommentsStatus.initial) {
          return const AspectRatio(
              aspectRatio: 1,
              child: Center(child: CircularProgressIndicator()));
        } else if (state.commentsStatus == CommentsStatus.loaded) {
          return ListView.builder(
            reverse: true,
            controller: controller,
            padding: widget.padding,
            itemBuilder: (ctx, index) {
              return CommentWidget(data: state.comments[index]);
            },
            itemCount: state.comments.length,
          );
        }
        // ignore: prefer_const_constructors
        return AspectRatio(
          aspectRatio: 1,
          child: const Center(
            child: Text(
              'Nothing here',
              style: TextStyle(color: Colors.black38),
            ),
          ),
        );
      },
    );
  }
}
