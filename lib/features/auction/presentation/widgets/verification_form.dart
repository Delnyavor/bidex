import 'package:bidex/common/widgets/modal_form/bottom_modal.dart';
import 'package:bidex/common/widgets/modal_form/button_cancel.dart';
import 'package:bidex/common/widgets/modal_form/button_proceed.dart';
import 'package:bidex/common/widgets/modal_form/form_input.dart';
import 'package:bidex/common/widgets/modal_form/heading.dart';
import 'package:bidex/common/widgets/modal_form/title.dart' as ttl;
import 'package:bidex/common/widgets/modal_form/top_section.dart';
import 'package:bidex/features/auction/presentation/widgets/bid_purchase_form.dart';
import 'package:bidex/features/auction/presentation/widgets/session_form.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';

class VerificationForm extends StatefulWidget {
  const VerificationForm({Key? key}) : super(key: key);

  @override
  State<VerificationForm> createState() => _VerificationFormState();
}

class _VerificationFormState extends State<VerificationForm> {
  TextEditingController controller = TextEditingController();
  late AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: 350,
          width: double.infinity,
          child: Column(
            children: [top(), bottom()],
          ),
        ),
      ),
    );
  }

  Widget top() {
    return Flexible(
      child: listener(
        child: TopSection(
          flex: true,
          children: [
            const ttl.Title(title: 'Verify'),
            const SizedBox(height: 8),
            const Heading(heading: 'Enter password to continue'),
            const SizedBox(height: 10),
            Flexible(
              child: ModalFormInput(
                  controller: controller, hint: '', obscure: true),
            ),
            handler(),
            const SizedBox(height: 100),
          ],
        ),
      ),
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
        if (state.hasBeenVerified) {
          Navigator.pop(context);
          showFormDialog(context, const SessionForm(), true);
        }
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
    if (kDebugMode) {
      print(controller.text);
    }
    authBloc.add(VerifyEvent(controller.text));
  }
}
