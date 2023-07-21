import 'package:bidex/common/widgets/input_field.dart';
import 'package:bidex/common/widgets/modal_form/bottom_modal.dart';
import 'package:bidex/features/home/presentation/widgets/global_app_bar.dart';
import 'package:bidex/features/payment/presentation/widgets/add_payment_method_card.dart';
import 'package:bidex/features/profile/presentation/widgets/edit_feedback_dialog.dart';
import 'package:bidex/features/profile/presentation/widgets/reset_password.dart';
import 'package:bidex/features/scaffolding/scaffold.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/modal_form/button_cancel.dart';
import '../../../../common/widgets/modal_form/button_proceed.dart';

class CreatePaymentMethodPage extends StatefulWidget {
  const CreatePaymentMethodPage({super.key});

  @override
  State<CreatePaymentMethodPage> createState() =>
      _CreatePaymentMethodPageState();
}

class _CreatePaymentMethodPageState extends State<CreatePaymentMethodPage> {
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
        const AddPaymentMethodCard(),
        InputField(label: 'Username', controller: username, prefix: '@ '),
        Row(
          children: [
            Flexible(child: InputField(label: 'First Name', controller: fName)),
            const SizedBox(width: 25),
            Flexible(child: InputField(label: 'Last Name', controller: lName)),
          ],
        ),
        InputField(label: 'Email', controller: email),
        InputField(label: 'Phone', controller: phone, prefix: '+233 '),
        GestureDetector(
          onTap: showResetModal,
          child: InputField(
            label: 'Password',
            controller: password,
            obscure: true,
            enabled: false,
          ),
        ),
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
              text: 'CHANGE',
              onPressed: () {
                showNormalDialog(context, const FeedbackDialog());
              })
        ],
      ),
    );
  }
}
