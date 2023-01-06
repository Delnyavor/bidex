import 'package:bidex/features/scaffolding/presentation/bloc/navigation_bloc.dart/bloc/navigation_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RevertButton extends StatefulWidget {
  const RevertButton({Key? key}) : super(key: key);

  @override
  State<RevertButton> createState() => _RevertButtonState();
}

class _RevertButtonState extends State<RevertButton> {
  late NavigationBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    bloc = BlocProvider.of<NavigationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        //revert sscaffold changes here
      },
      icon: const Icon(
        CupertinoIcons.back,
        size: 22,
      ),
    );
  }
}
