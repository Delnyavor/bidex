import 'package:bidex/features/home/presentation/widgets/global_app_bar.dart';
import 'package:bidex/features/home/presentation/widgets/global_bottom_bar.dart';
import 'package:bidex/features/home/presentation/widgets/home_body.dart';
import 'package:flutter/cupertino.dart';

import '../../../scaffolding/scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffolding(
      appBar: GlobalAppBar(),
      body: HomeBody(),
      bottomNavbar: GlobalBottomNavBar(),
    );
  }
}
