import 'package:bidex/common/app_colors.dart';
import 'package:bidex/common/app_routes.dart';
import 'package:bidex/common/transitions/route_transitions.dart';
import 'package:bidex/common/widgets/translucent_app_bar.dart';
import 'package:bidex/features/auth/presentation/login_bloc/login_bloc.dart';
import 'package:bidex/features/auth/presentation/widgets/auth_button.dart';
import 'package:bidex/features/auth/presentation/widgets/auth_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool shouldRememberPassword = false;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late LoginBloc bloc;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<LoginBloc>(context);
    bloc.add(const ValidationStateChanged(true));
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    bloc.add(const ValidationStateChanged(false));
  }

  void signIn() {
    bloc.add(
      LoginSubmitted(
          email: emailController.text, password: passwordController.text),
    );
  }

  void handleUnsiccessfulState(String error) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(error)),
      );
  }

  void handleSuccessfulState() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text(
            'Welcome to Bidex',
            style: TextStyle(color: AppColors.blue),
          ),
          backgroundColor: Colors.white,
        ),
      );
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(context, slideInRoute(const LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.translucentStatusAppBar,
      backgroundColor: AppColors.lightBlue,
      body: SafeArea(
        child: blocListener(),
      ),
    );
  }

  Widget blocListener() {
    return BlocListener<LoginBloc, LoginState>(
      bloc: bloc,
      listener: (context, state) {
        if (state.status == LoginPageStatus.failed) {
          handleUnsiccessfulState(state.error);
        }
        if (state.status == LoginPageStatus.successful) {
          handleSuccessfulState();
        }
      },
      child: builder(),
    );
  }

  Widget builder() {
    return SingleChildScrollView(
      child: body(),
    );
  }

  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 55),
          child: logo(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: formTitle(),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
            child: emailInput()),
        Padding(
          padding:
              const EdgeInsets.only(left: 32, right: 32, top: 10, bottom: 2),
          child: passwordInput(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: rememberPasswordCheckBox(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
          child: forgotPassword(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 26),
          child: signInButton(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
          child: partition(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 26),
          child: registerButton(),
        ),
      ],
    );
  }

  Widget logo() {
    return const Center(
      child: Text(
        'bidex',
        style: TextStyle(fontSize: 80, letterSpacing: -10),
      ),
    );
  }

  Widget formTitle() {
    return Text(
      'Sign in to continue',
      style: Theme.of(context)
          .textTheme
          .subtitle2!
          .copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget emailInput() {
    return BlocBuilder<LoginBloc, LoginState>(
      bloc: bloc,
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return AuthInput(
          controller: emailController,
          hint: 'Enter email',
          onChanged: (email) {
            bloc.add(EmailChanged(email));
          },
          errorText: state.shouldValidate
              ? state.email.validationToString(state.email.error)
              : null,
        );
      },
    );
  }

  Widget passwordInput() {
    return BlocBuilder<LoginBloc, LoginState>(
      bloc: bloc,
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return AuthInput(
          controller: passwordController,
          hint: 'Password',
          obscure: true,
          onChanged: (password) {
            bloc.add(PasswordChanged(password));
          },
          errorText: state.shouldValidate
              ? state.password.validationToString(state.password.error)
              : null,
        );
      },
    );
  }

  Widget rememberPasswordCheckBox() {
    return Row(
      children: [
        Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          side: const BorderSide(width: 1),
          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.pressed)) {
              return AppColors.darkBlue;
            }
            return AppColors.darkBlue;
          }),
          value: shouldRememberPassword,
          onChanged: (bool? value) {
            setState(() {
              shouldRememberPassword = value!;
            });
          },
        ),
        Text('Remember password', style: Theme.of(context).textTheme.caption!)
      ],
    );
  }

  Widget forgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {},
          child: Text(
            'Forgot password',
            style: Theme.of(context).textTheme.caption!.copyWith(
                  color: AppColors.darkBlue.withOpacity(0.6),
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }

  Widget partition() {
    return Row(
      children: [
        partitionDecoration(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'Not a member?',
            style: Theme.of(context).textTheme.overline!.copyWith(
                fontWeight: FontWeight.w600, letterSpacing: 0.8, height: 1.1),
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

  Widget signInButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      // buildWhen: (previous, current) => previous != current,
      bloc: bloc,
      builder: (context, state) {
        if (state.status == LoginPageStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return AuthButton(
          label: 'Sign In',
          light: false,
          flex: true,
          onPressed: () {
            FocusScope.of(context).unfocus();
            signIn();
          },
        );
      },
    );
  }

  Widget registerButton() {
    return AuthButton(
      label: 'Register',
      light: true,
      onPressed: () {
        Navigator.pushReplacementNamed(context, Routes.signup);
      },
      flex: true,
    );
  }
}
