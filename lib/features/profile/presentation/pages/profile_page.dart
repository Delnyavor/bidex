import 'package:bidex/features/profile/presentation/widgets/dropdown_create_post.dart';
import 'package:bidex/features/profile/presentation/widgets/dropdown_menu.dart';
import 'package:bidex/features/profile/presentation/widgets/user_info.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_colors.dart';
import '../../domain/entities/user_post.dart';
import '../widgets/dropdown_filter.dart';
import '../widgets/user_post_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  GlobalKey key = GlobalKey();
  double spacing = 16.0;

  List<UserPost> posts = [];

  @override
  void initState() {
    super.initState();
    posts = List.generate(
      4,
      (index) => UserPost(
        "assets/images/stock$index.jpg",
        PostType.auction,
        PostStatus.published,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: spacing),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: UserInfoWidget(),
            ),
            SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: spacing,
                crossAxisSpacing: spacing,
              ),
              itemBuilder: (c, i) {
                return UserPostWidget(
                  post: posts[i],
                );
              },
              itemCount: posts.length,
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 80))
          ],
        ),
      ),
      floatingActionButton: floatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget floatingButton() {
    return DecoratedBox(
      key: key,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.buttonLightBlue,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilterDropdown(parentKey: key),
            const SizedBox(width: 10),
            AddPostMenuDropdown(parentKey: key),
            const SizedBox(width: 10),
            ProfileMenuDropdown(parentKey: key),
          ],
        ),
      ),
    );
  }
}
