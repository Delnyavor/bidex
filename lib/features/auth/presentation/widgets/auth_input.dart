import 'package:flutter/material.dart';

class AuthInput extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  final bool? obscure;
  final Function(String)? onChanged;
  final String? errorText;

  const AuthInput({
    super.key,
    this.validator,
    required this.controller,
    required this.hint,
    this.obscure,
    this.onChanged,
    this.errorText,
  });

  @override
  State<AuthInput> createState() => _AuthInputState();
}

class _AuthInputState extends State<AuthInput> {
  bool invisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      obscureText: shouldObscure(),
      style: const TextStyle(fontSize: 12),
      decoration: InputDecoration(
        hintText: widget.hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 18,
        ),
        suffixIcon: iconBuilder(),
        errorText: widget.errorText,
      ),
      onChanged: widget.onChanged,
    );
  }

  Widget iconBuilder() {
    if (widget.obscure != null && widget.obscure == true) {
      return suffixIcon();
    } else {
      return const SizedBox.shrink();
    }
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
