import 'package:flutter/material.dart';

import 'modal_form/form_input.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? prefix;
  final bool? obscure;
  final bool? enabled;

  const InputField(
      {super.key,
      required this.label,
      required this.controller,
      this.prefix,
      this.obscure,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelWidget(label),
          const SizedBox(height: 10),
          ModalFormInput(
            controller: controller,
            hint: '',
            prefix: prefix == null
                ? null
                : Text(
                    prefix!,
                  ),
            obscure: obscure,
            enabled: enabled,
          ),
        ],
      ),
    );
  }

  Widget labelWidget(String label) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.black.withOpacity(0.65),
        fontSize: 12,
        fontWeight: FontWeight.w200,
      ),
    );
  }
}
