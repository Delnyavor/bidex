import 'package:bidex/common/app_colors.dart';
import 'package:bidex/common/transitions/route_transitions.dart';
import 'package:bidex/common/widgets/translucent_app_bar.dart';
import 'package:bidex/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bidex/features/auth/presentation/pages/add_user_details_page.dart';
import 'package:bidex/features/auth/presentation/pages/registration_sub_pages/account_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  late AuthBloc bloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<AuthBloc>(context);
  }

  void handleUnsuccessfulRegistrationState(String error) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(error)),
      );
  }

  void handleSuccessfulRegistrationState() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text(
            'Welcome to Bidex',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.darkBlue,
        ),
      );
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, slideInRoute(const AddUserDetailsPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.translucentStatusAppBar,
      backgroundColor: AppColors.lightBlue,
      body: SafeArea(
        child: listener(),
      ),
    );
  }

  Widget listener() {
    return BlocListener<AuthBloc, AuthState>(
      bloc: bloc,
      listener: (context, state) {
        if (state.pageStatus == RegistrationPageStatus.failed) {
          handleUnsuccessfulRegistrationState(state.error);
        }
        if (state.pageStatus == RegistrationPageStatus.successful) {
          handleSuccessfulRegistrationState();
        }
      },
      child: body(),
    );
  }

  Widget body() {
    return Column(
      children: [
        logo(),
        const Flexible(
          child: AccountInfoForm(),
        ),
      ],
    );
  }

  Widget logo() {
    return AspectRatio(
      aspectRatio: 1.6,
      child: Transform.scale(
        scale: 0.7,
        child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
