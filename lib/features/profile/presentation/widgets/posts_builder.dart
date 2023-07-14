import "package:bidex/features/profile/presentation/widgets/user_post_widget.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../domain/entities/user_post.dart";
import "../bloc/profile_bloc.dart";

class UserPostsBuilder extends StatefulWidget {
  const UserPostsBuilder({super.key});

  @override
  State<UserPostsBuilder> createState() => _UserPostsBuilderState();
}

class _UserPostsBuilderState extends State<UserPostsBuilder> {
  double spacing = 16.0;

  List<UserPost> posts = [];

  @override
  void initState() {
    super.initState();
    posts = List.generate(
      3,
      (index) => UserPost(
        "assets/images/stock$index.jpg",
        PostType.auction,
        PostStatus.published,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return Padding(
        padding: EdgeInsets.all(spacing),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              mainAxisSpacing: spacing,
              crossAxisSpacing: spacing),
          itemBuilder: (c, i) {
            return UserPostWidget(
              post: posts[i],
            );
          },
          itemCount: posts.length,
        ),
      );
    });
  }
}
