import 'package:bidex/common/widgets/modal_form/bottom_modal.dart';
import 'package:bidex/common/widgets/modal_form/form_input.dart';
import 'package:bidex/features/home/presentation/widgets/global_app_bar.dart';
import 'package:bidex/features/profile/presentation/widgets/edit_feedback_dialog.dart';
import 'package:bidex/features/profile/presentation/widgets/reset_password.dart';
import 'package:bidex/features/scaffolding/scaffold.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/modal_form/button_cancel.dart';
import '../../../../common/widgets/modal_form/button_proceed.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController username = TextEditingController();
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffolding(
      appBar: const GlobalAppBar(),
      body: body(),
      bottomNavbar: bottom(),
    );
  }

  @override
  void dispose() {
    username.dispose();
    fName.dispose();
    lName.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();
  }

  void showResetModal() async {
    String? result =
        await showFormDialog(context, const ResetPasswordModal(), true);
    if (result != null) {
      setState(() {
        password.text = result;
      });
    }
  }

  Widget body() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
      children: [
        textField('Username', username, prefix: '@ '),
        Row(
          children: [
            Flexible(child: textField('First Name', fName)),
            const SizedBox(width: 25),
            Flexible(child: textField('Last Name', lName)),
          ],
        ),
        textField('Email', email),
        textField('Phone', phone, prefix: '+233 '),
        GestureDetector(
            onTap: showResetModal,
            child:
                textField('Password', password, obscure: true, enabled: false)),
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
      padding: const EdgeInsets.only(top: 30.0),
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
              text: 'CHANGE',
              onPressed: () {
                showNormalDialog(context, const FeedbackDialog());
              })
        ],
      ),
    );
  }
}
