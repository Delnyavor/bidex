import 'package:bidex/features/profile/presentation/widgets/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class AddPostMenuDropdown extends StatefulWidget {
  final GlobalKey parentKey;
  const AddPostMenuDropdown({super.key, required this.parentKey});

  @override
  State<AddPostMenuDropdown> createState() => _AddPostMenuDropdownState();
}

class _AddPostMenuDropdownState extends State<AddPostMenuDropdown> {
  @override
  Widget build(BuildContext context) {
    return CustomDropdown<Function>(
        parentKey: widget.parentKey,
        icon: const Icon(CupertinoIcons.plus_square),
        onChange: (Function value, int index) => () {},
        dropdownButtonStyle: const DropdownButtonStyle(
          width: 50,
          height: 45,
          backgroundColor: Colors.white,
          primaryColor: Colors.black87,
        ),
        dropdownStyle: DropdownStyle(
          borderRadius: BorderRadius.circular(20),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2),
        ),
        items: [
          DropdownItem<Function>(
            value: () {},
            child: const Text('Barter'),
          ),
          DropdownItem<Function>(
            value: () {},
            child: const Text('Auction'),
          ),
          DropdownItem<Function>(
            value: () {},
            child: const Text('Gift'),
          ),
        ]);
  }
}
