import 'package:bidex/common/app_colors.dart';
import 'package:flutter/material.dart';

class ModalFormInput extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String? errorText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool? obscure;
  final bool? enabled;
  final Widget? prefix;
  final Widget? suffix;
  final int? maxLines;
  final bool revealBorder;
  final TextInputType? inputType;

  const ModalFormInput({
    Key? key,
    this.validator,
    required this.controller,
    required this.hint,
    this.obscure,
    this.onChanged,
    this.errorText,
    this.enabled = true,
    this.prefix,
    this.suffix,
    this.maxLines = 1,
    this.revealBorder = true,
    this.inputType,
  }) : super(key: key);

  @override
  State<ModalFormInput> createState() => _ModalFormInputState();
}

class _ModalFormInputState extends State<ModalFormInput> {
  bool invisible = true;
  FocusNode focusNode = FocusNode();
  bool hasfocus = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus && !hasfocus) {
        setState(() {
          hasfocus = true;
        });
      } else if (!focusNode.hasFocus && hasfocus) {
        setState(() {
          hasfocus = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.inputType,
      focusNode: focusNode,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      obscureText: shouldObscure(),
      obscuringCharacter: '*',
      maxLines: widget.maxLines,
      minLines: 1,
      style: const TextStyle(fontSize: 12),
      cursorColor: AppColors.brightBlue,
      enabled: widget.enabled,
      decoration: InputDecoration(
        hintText: widget.hint,
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 18,
        ),
        prefix: widget.prefix,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: buildBorder(),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), borderSide: buildBorder()),
        focusedErrorBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        errorText: widget.errorText,
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        suffixIcon: widget.suffix,
      ),
      onChanged: widget.onChanged,
    );
  }

  BorderSide buildBorder() {
    return widget.revealBorder
        ? BorderSide(
            width: hasfocus ? 1 : 0,
            color: hasfocus ? AppColors.brightBlue : Colors.black26,
          )
        : BorderSide.none;
  }

  Widget suffixIcon() {
    return GestureDetector(
      onTap: () {
        setState(() {
          invisible = !invisible;
        });
      },
      child: Icon(invisible ? Icons.visibility_off_outlined : Icons.visibility),
    );
  }

  bool shouldObscure() {
    if (widget.obscure != null && widget.obscure == true) {
      return invisible;
    } else {
      return false;
    }
  }
}
