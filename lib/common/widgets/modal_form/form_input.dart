import 'package:flutter/material.dart';

class ModalFormInput extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  final bool? obscure;
  final Function(String)? onChanged;
  final bool enabled;
  final String? errorText;

  const ModalFormInput({
    Key? key,
    this.validator,
    required this.controller,
    required this.hint,
    this.obscure,
    this.onChanged,
    this.errorText,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<ModalFormInput> createState() => ModalFormInputState();
}

class ModalFormInputState extends State<ModalFormInput> {
  bool invisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      obscureText: shouldObscure(),
      obscuringCharacter: '*',
      style: const TextStyle(fontSize: 12),
      enabled: widget.enabled,
      decoration: InputDecoration(
        hintText: widget.hint,
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 18,
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
