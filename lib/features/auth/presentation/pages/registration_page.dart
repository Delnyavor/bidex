import 'package:bidex/common/app_colors.dart';
import 'package:bidex/common/route_transitions.dart';
import 'package:bidex/common/scroll_behaviour.dart';
import 'package:bidex/common/widgets/translucent_app_bar.dart';
import 'package:bidex/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bidex/features/auth/presentation/pages/registration_sub_pages/account_info.dart';
import 'package:bidex/features/auth/presentation/pages/registration_sub_pages/personal_info_form.dart';
import 'package:bidex/features/auth/presentation/pages/registration_sub_pages/personal_info_identity_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  late List<Widget> pages;
  late AuthBloc bloc;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    pages = [
      const AccountInfoForm(),
      const PersonalInfoForm(),
      const IdentityForm(),
    ];
    controller = PageController(keepPage: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<AuthBloc>(context);
    addListener();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void addListener() {
    controller.addListener(() {
      int page = controller.page!.floor().toInt();
      if (page != bloc.state.page) {
        bloc.add(PageChanged(page, false));
      }
    });
  }

  void handlePageStateChanged(int page) {
    controller.animateToPage(page,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut);
  }

  void handleUnsuccessfulState(String error) {
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
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.darkBlue,
        ),
      );
    Future.delayed(const Duration(seconds: 2), () {
      //TODO: chagnge to pushreplacement
      Navigator.push(context, slideInRoute(const Scaffold()));
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
          handleUnsuccessfulState(state.error);
        }
        if (state.pageStatus == RegistrationPageStatus.successful) {
          handleSuccessfulState();
        }
        if (state.shouldChangePage) {
          handlePageStateChanged(state.page);
        }
      },
      child: body(),
    );
  }

  Widget body() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50, bottom: 75),
          child: logo(),
        ),
        Flexible(
          child: PageView(
            controller: controller,
            scrollBehavior: NoOverScrollGlowBehavior(),
            children: pages,
          ),
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
}
