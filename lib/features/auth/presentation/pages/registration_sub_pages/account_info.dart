import 'package:bidex/common/app_colors.dart';
import 'package:bidex/common/transitions/route_transitions.dart';
import 'package:bidex/common/transitions/scroll_behaviour.dart';
import 'package:bidex/features/auth/data/models/email.dart';
import 'package:bidex/features/auth/data/models/password.dart';
import 'package:bidex/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bidex/features/auth/presentation/pages/login_page.dart';
import 'package:bidex/features/auth/presentation/widgets/auth_button.dart';
import 'package:bidex/features/auth/presentation/widgets/auth_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountInfoForm extends StatefulWidget {
  const AccountInfoForm({Key? key}) : super(key: key);

  @override
  State<AccountInfoForm> createState() => AccountInfoFormState();
}

class AccountInfoFormState extends State<AccountInfoForm>
    with AutomaticKeepAliveClientMixin {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late AuthBloc bloc;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  bool get wantKeepAlive => true;

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 11),
                child: emailInput()),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 11),
                child: passwordInput()),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 11),
                child: confirmPasswordInput()),
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

  Widget emailInput() {
    return AuthInput(
      controller: emailController,
      hint: 'Enter email',
      onChanged: (email) {
        bloc.add(EmailChanged(email));
      },
      validator: (value) {
        final email = Email.dirty(value!);
        final error = email.validator(value);
        return email.validationToString(error);
      },
    );
  }

  Widget passwordInput() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) => AuthInput(
        controller: passwordController,
        obscure: true,
        hint: 'Enter password',
        onChanged: (email) {
          bloc.add(PasswordChanged(
              passwordController.text, confirmPasswordController.text));
        },
        validator: (value) {
          final password = Password.dirty(value!);
          final error = password.validator(value);
          if (error == null &&
              passwordController.text != state.confirmPassword.value) {
            return password
                .validationToString(PasswordValidationError.mismatch);
          }
          return password.validationToString(error);
        },
      ),
    );
  }

  Widget confirmPasswordInput() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) => AuthInput(
        controller: confirmPasswordController,
        obscure: true,
        hint: 'Enter password',
        onChanged: (email) {
          bloc.add(PasswordChanged(
              passwordController.text, confirmPasswordController.text));
        },
        validator: (value) {
          final password = Password.dirty(value!);
          final error = password.validator(value);
          if (error == null &&
              confirmPasswordController.text != state.password.value) {
            return password
                .validationToString(PasswordValidationError.mismatch);
          }
          return password.validationToString(error);
        },
      ),
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
                color: AppColors.darkBlue.withOpacity(0.6),
                letterSpacing: 0.8,
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
        builder: (BuildContext context, state) {
      return AuthButton(
        label: 'Register',
        light: false,
        flex: true,
        onPressed: () {
          bloc.add(RegisterUser());
        },
      );
    });
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
