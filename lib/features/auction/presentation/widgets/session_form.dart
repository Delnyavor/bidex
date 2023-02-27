import 'package:bidex/common/widgets/modal_form/bottom_modal.dart';
import 'package:bidex/common/widgets/modal_form/button_cancel.dart';
import 'package:bidex/common/widgets/modal_form/button_proceed.dart';
import 'package:bidex/common/widgets/modal_form/form_input.dart';
import 'package:bidex/common/widgets/modal_form/heading.dart';
import 'package:bidex/common/widgets/modal_form/title.dart' as ttl;
import 'package:bidex/common/widgets/modal_form/top_section.dart';
import 'package:bidex/features/auction/presentation/widgets/payment_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';

class SessionForm extends StatefulWidget {
  const SessionForm({Key? key}) : super(key: key);

  @override
  State<SessionForm> createState() => _SessionFormState();
}

class _SessionFormState extends State<SessionForm> {
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController controller = TextEditingController();
  late AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [top(), bottom()],
      ),
    );
  }

  Widget top() {
    return Flexible(
      child: listener(
        child: TopSection(
          flex: false,
          children: [
            const ttl.Title(title: 'Details'),
            const SizedBox(height: 8),
            const Heading(
                heading:
                    'Choose contact details for auction session and select payment method'),
            const SizedBox(height: 14),
            Flexible(
              child: ModalFormInput(controller: username, hint: 'Username'),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: ModalFormInput(controller: phone, hint: 'Phone Number'),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: GestureDetector(
                onTap: () {
                  showPaymentOptionDialog(context, const PaymentSelector());
                },
                child: ModalFormInput(
                  controller: controller,
                  hint: 'Select Payment Method',
                  enabled: false,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // handler(),
            details(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget details() {
    return const Text(
      'An auction fee of 10GHC shall be deducted from your selected payment option',
      style: TextStyle(
          fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
    );
  }

  Widget handler() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.verificationPageStatus == VerificationPageStatus.failed) {
          return const Text(
              'Operation Failed. Check that your password is correct');
        }
        if (state.verificationPageStatus == VerificationPageStatus.loading) {
          return const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
              child: SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  )),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget listener({required Widget child}) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // if (state.hasBeenVerified) {
        //   Navigator.pop(context);
        //   showFormDialog(context, const SessionForm());
        // }
      },
      child: child,
    );
  }

  Widget bottom() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CancelButton(text: 'CANCEL'),
          ProceedButton(text: 'PROCEED', onPressed: verify)
        ],
      ),
    );
  }

  void verify() {
    print(controller.text);
    authBloc.add(VerifyEvent(controller.text));
  }
}
