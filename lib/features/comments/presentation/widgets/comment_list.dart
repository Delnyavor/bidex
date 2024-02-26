import 'package:bidex/features/comments/presentation/bloc/comment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentList extends StatefulWidget {
  final String postId;
  final String? commentId;
  const CommentList({super.key, required this.postId, this.commentId});

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  late CommentBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<CommentBloc>(context);
    bloc.add(FetchComments(postId: widget.postId));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: widget.commentId == null
            ? const CircularProgressIndicator()
            : const SizedBox(
                width: 20, height: 20, child: CircularProgressIndicator()));
  }
}
