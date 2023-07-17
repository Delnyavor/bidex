import 'package:flutter/material.dart';

import '../../../../common/widgets/modal_form/button_cancel.dart';
import '../../../../common/widgets/modal_form/button_proceed.dart';
import '../../../../common/widgets/modal_form/form_input.dart';
import '../../../../common/widgets/modal_form/heading.dart';
import '../../../../common/widgets/modal_form/top_section.dart';
import 'package:bidex/common/widgets/modal_form/title.dart' as ttl;

class ResetPasswordModal extends StatefulWidget {
  const ResetPasswordModal({super.key});

  @override
  State<ResetPasswordModal> createState() => ResetPasswordModalState();
}

class ResetPasswordModalState extends State<ResetPasswordModal> {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPass = TextEditingController();

  @override
  void dispose() {
    oldPassword.dispose();
    newPassword.dispose();
    confirmNewPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [top(), bottom()],
        ),
      ),
    );
  }

  Widget top() {
    return TopSection(
      flex: true,
      children: [
        const ttl.Title(title: 'Change password'),
        const SizedBox(height: 12),
        const Heading(heading: 'Enter one-time password sent to +233205551234'),
        const SizedBox(height: 12),
        textField('Old Password', oldPassword),
        textField('New Password', newPassword),
        textField('Confirm Password', confirmNewPass),
        const SizedBox(height: 100),
      ],
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.black.withOpacity(0.65),
        fontSize: 12,
        fontWeight: FontWeight.w200,
      ),
    );
  }

  Widget textField(String label, TextEditingController controller,
      {String? prefix, bool? obscure, bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          this.label(label),
          const SizedBox(height: 10),
          ModalFormInput(
            controller: controller,
            hint: '',
            prefix: prefix == null
                ? null
                : Text(
                    prefix,
                  ),
            obscure: obscure,
            enabled: enabled,
          ),
        ],
      ),
    );
  }

  Widget bottom() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CancelButton(text: 'CANCEL'),
          ProceedButton(
              text: 'UPDATE',
              onPressed: () {
                Navigator.pop(context, confirmNewPass.text);
              })
        ],
      ),
    );
  }
}
