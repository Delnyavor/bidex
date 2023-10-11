import 'package:bidex/common/app_colors.dart';
import 'package:bidex/common/transitions/route_transitions.dart';
import 'package:bidex/common/widgets/translucent_app_bar.dart';
import 'package:bidex/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bidex/features/auth/presentation/pages/registration_sub_pages/personal_info_form.dart';
import 'package:bidex/features/auth/presentation/pages/registration_sub_pages/personal_info_identity_form.dart';
import 'package:bidex/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserDetailsPage extends StatefulWidget {
  const AddUserDetailsPage({Key? key}) : super(key: key);

  @override
  State<AddUserDetailsPage> createState() => AddUserDetailsPageState();
}

class AddUserDetailsPageState extends State<AddUserDetailsPage> {
  late AuthBloc bloc;
  List<Widget> pages = [];

  bool canShow = false;

  @override
  void initState() {
    super.initState();
    pages = const [
      PersonalInfoForm(),
      IdentityForm(),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<AuthBloc>(context);
  }

  void handleUnsuccessfulRegistrationState(String error) {
    if (canShow) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(error)),
        );
    }
  }

  void handleSuccessfulRegistrationState() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text(
            'Welcome',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.darkBlue,
        ),
      );
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, slideInRoute(const HomePage()));
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
        if (state.registrationUserDetailsPageStatus ==
            RegistrationUserDetailsPageStatus.loading) {
          if (!canShow) {
            setState(() {
              canShow = true;
            });
          }
        }
        if (state.registrationUserDetailsPageStatus ==
            RegistrationUserDetailsPageStatus.failed) {
          handleUnsuccessfulRegistrationState(state.error);
          if (canShow) {
            setState(() {
              canShow = false;
            });
          }
        }
        if (state.registrationUserDetailsPageStatus ==
            RegistrationUserDetailsPageStatus.successful) {
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
        Flexible(
          child: PageView(
            children: pages,
          ),
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
