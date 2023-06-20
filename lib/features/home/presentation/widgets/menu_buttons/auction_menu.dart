import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../barter/presentation/bloc/barter_bloc.dart';

class BarterPopupMenu extends StatefulWidget {
  const BarterPopupMenu({Key? key}) : super(key: key);

  @override
  State<BarterPopupMenu> createState() => BarterPopupMenuState();
}

class BarterPopupMenuState extends State<BarterPopupMenu> {
  late BarterBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<BarterBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<BarterMenuOption>(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: BarterMenuOption.one,
            child: Text(BarterMenuOption.one.toString()),
          ),
          PopupMenuItem(
            value: BarterMenuOption.two,
            child: Text(BarterMenuOption.two.toString()),
          ),
          PopupMenuItem(
            value: BarterMenuOption.three,
            child: Text(BarterMenuOption.three.toString()),
          ),
        ];
      },
      onSelected: (option) {
        switch (option) {
          case BarterMenuOption.one:
            break;
          case BarterMenuOption.two:
            break;
          case BarterMenuOption.three:
            break;
        }
      },
      icon: const Icon(
        CupertinoIcons.plus_square,
        size: 22,
      ),
    );
  }
}

enum BarterMenuOption { one, two, three }
