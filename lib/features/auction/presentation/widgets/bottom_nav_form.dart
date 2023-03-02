import 'package:bidex/common/app_colors.dart';
import 'package:flutter/material.dart';

class BottomNavBidForm extends StatefulWidget {
  const BottomNavBidForm({Key? key}) : super(key: key);

  @override
  State<BottomNavBidForm> createState() => _BottomNavBidFormState();
}

class _BottomNavBidFormState extends State<BottomNavBidForm> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 4,
            spreadRadius: -3,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          form(),
          const SizedBox(height: 8),
          button(),
        ],
      ),
    );
  }

  Widget button() {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
        backgroundColor: AppColors.darkBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        '+GHC100',
        style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5),
      ),
    );
  }

  Widget form() {
    return Row(
      children: [
        const Flexible(flex: 1, child: Center()),
        Flexible(flex: 9, child: BottomBarInput(controller: controller)),
        Flexible(
          flex: 1,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.payment_rounded),
          ),
        ),
      ],
    );
  }
}

class BottomBarInput extends StatefulWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String? errorText;

  const BottomBarInput({
    Key? key,
    required this.controller,
    this.onChanged,
    this.errorText,
  }) : super(key: key);

  @override
  State<BottomBarInput> createState() => BottomBarInputState();
}

class BottomBarInputState extends State<BottomBarInput> {
  bool invisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      style: const TextStyle(fontSize: 12, color: AppColors.darkBlue),
      maxLines: 1,
      decoration: InputDecoration(
        hintText: 'Enter the amount you\'d like to bid',
        hintStyle: const TextStyle(color: AppColors.darkBlue),
        filled: true,
        fillColor: AppColors.lightBlue,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        focusedErrorBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        errorText: widget.errorText,
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
      ),
      onChanged: widget.onChanged,
    );
  }
}
