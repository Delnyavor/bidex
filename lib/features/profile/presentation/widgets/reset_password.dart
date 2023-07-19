import 'package:bidex/common/widgets/input_field.dart';
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
        InputField(label: 'Old Password', controller: oldPassword),
        InputField(label: 'New Password', controller: newPassword),
        InputField(label: 'Confirm Password', controller: confirmNewPass),
        const SizedBox(height: 100),
      ],
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
