import 'package:bidex/di/injection_container.dart';
import 'package:bidex/features/comments/domain/entities/comment.dart';
import 'package:bidex/features/comments/domain/repositories/comments_repository.dart';
import 'package:bidex/features/comments/domain/usecases/get_comments.dart';
import 'package:bidex/features/comments/presentation/widgets/comment_widget.dart';
import 'package:flutter/material.dart';

class CommentList extends StatefulWidget {
  final String postId;
  final String? commentId;
  const CommentList({super.key, required this.postId, this.commentId});

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  late GetComments getComments;
  late List<int> comments;
  late Future fetch;

  @override
  void initState() {
    super.initState();
    getComments = GetComments(repository: sl<CommentsRepository>());
    fetch = getData();
  }

  getData() async {
    return await Future.delayed(const Duration(seconds: 5), () {
      return List.generate(10, (index) => index + 1);
    });

    // final res = await getComments(id: widget.postId);
    // res!.fold((l) => null, (r) {
    //   comments = r;
    // });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      comments = await getData();
      print(comments);
    });
    return FutureBuilder(
        future: fetch,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              // print(snapshot.data);
              return Column(
                children: snapshot.data
                    .map<Widget>((e) => CommentWidget(data: e.toString()))
                    .toList(),
              );
            }
          }
          return Center(
              child: widget.commentId == null
                  ? const CircularProgressIndicator()
                  : const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator()));
        });
  }
}
