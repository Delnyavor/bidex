import 'package:bidex/common/app_colors.dart';
import 'package:bidex/common/transitions/route_transitions.dart';
import 'package:bidex/common/transitions/scroll_behaviour.dart';
import 'package:bidex/features/auth/data/models/phone.dart';
import 'package:bidex/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bidex/features/auth/presentation/pages/login_page.dart';
import 'package:bidex/features/auth/presentation/widgets/auth_button.dart';
import 'package:bidex/features/auth/presentation/widgets/auth_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/widgets/image_picker_widget.dart';

class IdentityForm extends StatefulWidget {
  const IdentityForm({Key? key}) : super(key: key);

  @override
  State<IdentityForm> createState() => IdentityFormState();
}

class IdentityFormState extends State<IdentityForm>
    with AutomaticKeepAliveClientMixin {
  late TextEditingController phoneController;
  late AuthBloc bloc;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void register() {
    bloc.add(RegistrationSubmitted());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ScrollConfiguration(
      behavior: NoOverScrollGlowBehavior(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: formTitle(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 11),
              child: imagePicker(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 11),
              child: phoneInput(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 25),
              child: registerButton(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
              child: partition(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 25),
              child: signInButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget formTitle() {
    return Text(
      'Create an account, it\'s free',
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.darkBlue,
          ),
    );
  }

  Widget imagePicker() {
    return ImagePickerWidget(
      onRetrieved: (path) {
        bloc.add(ImageChanged(path));
      },
    );
  }

  Widget phoneInput() {
    return AuthInput(
      controller: phoneController,
      hint: 'Phone',
      onChanged: (value) {
        bloc.add(PhoneChanged(value));
      },
      validator: (value) {
        final phone = Phone.dirty(value!);
        final error = phone.validator(value);
        return phone.validationToString(error);
      },
    );
  }

  Widget partition() {
    return Row(
      children: [
        partitionDecoration(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'Already a member?',
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.darkBlue.withOpacity(0.8),
                letterSpacing: 0.6,
                height: 1.1),
          ),
        ),
        partitionDecoration(),
      ],
    );
  }

  Widget partitionDecoration() {
    return const Flexible(
      child: Divider(
        height: 3,
        thickness: 0,
        color: AppColors.mutedBlue,
      ),
    );
  }

  Widget registerButton() {
    return BlocBuilder<AuthBloc, AuthState>(
      // buildWhen: (previous, current) => previous != current,
      bloc: bloc,
      builder: (context, state) {
        if (state.pageStatus == RegistrationPageStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return AuthButton(
          label: 'Finish',
          light: false,
          flex: true,
          onPressed: () {
            FocusScope.of(context).unfocus();
            register();
          },
        );
      },
    );
  }

  Widget signInButton() {
    return AuthButton(
      label: 'Sign In',
      light: true,
      onPressed: () {
        Navigator.pushReplacement(context, fadeInRoute(const LoginPage()));
      },
      flex: true,
    );
  }
}
