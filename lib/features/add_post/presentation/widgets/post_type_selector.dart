import 'package:bidex/common/app_colors.dart';
import 'package:bidex/features/add_post/presentation/bloc/create_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostTypeSelector extends StatefulWidget {
  final bool enabled;
  const PostTypeSelector({super.key, this.enabled = true});

  @override
  State<PostTypeSelector> createState() => _PostTypeSelectorState();
}

class _PostTypeSelectorState extends State<PostTypeSelector> {
  late double width;
  late CreatePostBloc bloc;
  double padding = 16;

  List<String> types = ['Gift', 'Auction', 'Barter'];
  List<IconData> icons = [
    Icons.card_giftcard,
    Icons.gavel_rounded,
    Icons.swap_vert_circle
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.of(context).size.width - padding * 2;
    bloc = BlocProvider.of<CreatePostBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      enabled: widget.enabled,
      initialSelection: types.first,
      width: width,
      textStyle: textStyle(),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[100],
      ),
      menuStyle: MenuStyle(
        elevation: MaterialStateProperty.all<double>(2),
        shape: MaterialStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      ),
      trailingIcon: const Icon(Icons.change_circle_outlined),
      dropdownMenuEntries: List.generate(
        3,
        (index) => DropdownMenuEntry(
          value: types[index],
          label: types[index].toString(),
          leadingIcon: Icon(
            icons[index],
            color: Colors.black54,
            size: 18,
          ),
          style: ButtonStyle(
              textStyle: MaterialStatePropertyAll<TextStyle>(
            dropDownTextStyle(),
          )),
        ),
      ),
      onSelected: (value) {
        bloc.add(SwitchPostTypeEvent(page: types.indexOf(value!)));
      },
    );
  }

  TextStyle textStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: AppColors.darkBlue.withOpacity(0.7),
      fontSize: 13,
    );
  }

  TextStyle dropDownTextStyle() {
    return const TextStyle(
      fontSize: 13,
    );
  }
}
