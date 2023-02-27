import 'package:flutter/material.dart';

class ModalDropDown extends StatefulWidget {
  final Function(String)? onChanged;

  const ModalDropDown({
    Key? key,
    this.onChanged,
  }) : super(key: key);

  @override
  State<ModalDropDown> createState() => _ModalDropDownState();
}

class _ModalDropDownState extends State<ModalDropDown> {
  bool invisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: button(),
    );
  }

  int? value;

  Widget button() {
    return DropdownButton<int>(
      hint: hint(),
      underline: const SizedBox.shrink(),
      isExpanded: true,
      borderRadius: BorderRadius.circular(12),
      value: value,
      items: [1, 2, 3, 4, 5]
          .map(
            (e) => DropdownMenuItem<int>(
              value: e,
              child: Text(e.toString()),
            ),
          )
          .toList(),
      onChanged: (int? value) {
        setState(() {
          this.value = value;
        });
      },
    );
  }

  Widget hint() {
    return const Text(
      'Set number of bids',
      style: TextStyle(fontSize: 12, color: Colors.black38),
    );
  }
}
