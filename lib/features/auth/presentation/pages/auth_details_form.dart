import 'package:bidex/common/app_colors.dart';
import 'package:bidex/common/transitions/route_transitions.dart';
import 'package:bidex/common/transitions/scroll_behaviour.dart';
import 'package:bidex/common/widgets/translucent_app_bar.dart';
import 'package:bidex/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bidex/features/auth/presentation/pages/registration_sub_pages/account_info.dart';
import 'package:bidex/features/auth/presentation/pages/registration_sub_pages/personal_info_form.dart';
import 'package:bidex/features/home/presentation/pages/home_page.dart';
import 'package:bidex/features/auth/presentation/pages/registration_sub_pages/personal_info_identity_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthDetailsForm extends StatefulWidget {
  const AuthDetailsForm({Key? key}) : super(key: key);

  @override
  State<AuthDetailsForm> createState() => AuthDetailsStateForm();
}

class AuthDetailsStateForm extends State<AuthDetailsForm> {
  late AuthBloc bloc;
  PageController controller = PageController();
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      const PersonalInfoForm(),
      const IdentityForm(),
    ];
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
        // if (state.pageStatus == AuthDetailsStatusForm.failed) {
        //   handleUnsuccessfulState(state.error);
        // }
        // if (state.pageStatus == AuthDetailsStatusForm.successful) {
        //   handleSuccessfulState();
        // }
        // if (state.shouldChangePage) {
        //   handlePageStateChanged(state.page);
        // }
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
            controller: controller,
            scrollBehavior: NoOverScrollGlowBehavior(),
            physics: const NeverScrollableScrollPhysics(),
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
