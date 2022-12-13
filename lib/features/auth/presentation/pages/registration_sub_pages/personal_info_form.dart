import 'package:bidex/common/app_colors.dart';
import 'package:bidex/common/transitions/route_transitions.dart';
import 'package:bidex/common/transitions/scroll_behaviour.dart';
import 'package:bidex/core/utils/validators.dart';
import 'package:bidex/features/auth/data/models/name.dart';
import 'package:bidex/features/auth/data/models/username.dart';
import 'package:bidex/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bidex/features/auth/presentation/pages/login_page.dart';
import 'package:bidex/features/auth/presentation/widgets/auth_button.dart';
import 'package:bidex/features/auth/presentation/widgets/auth_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalInfoForm extends StatefulWidget {
  const PersonalInfoForm({Key? key}) : super(key: key);

  @override
  State<PersonalInfoForm> createState() => PersonalInfoFormState();
}

class PersonalInfoFormState extends State<PersonalInfoForm>
    with AutomaticKeepAliveClientMixin {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController usernameController;
  late AuthBloc bloc;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    usernameController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
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
                child: fNameInput()),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 11),
                child: lNameInput()),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 11),
                child: usernameInput()),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 25),
              child: continueButton(),
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
      style: Theme.of(context)
          .textTheme
          .subtitle2!
          .copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget fNameInput() {
    return AuthInput(
      controller: firstNameController,
      hint: 'First name',
      onChanged: (value) {
        bloc.add(FirstNameChanged(value));
      },
      validator: (value) {
        final firstName = Name.dirty(value!);
        final error = firstName.validator(value);
        return firstName.validationToString(error);
      },
    );
  }

  Widget lNameInput() {
    return AuthInput(
      controller: lastNameController,
      hint: 'Last name',
      onChanged: (value) {
        bloc.add(LastNameChanged(value));
      },
      validator: (value) {
        final lastName = Name.dirty(value!);
        final error = lastName.validator(value);
        return lastName.validationToString(error);
      },
    );
  }

  Widget usernameInput() {
    return AuthInput(
      controller: usernameController,
      hint: 'Username',
      onChanged: (value) {
        bloc.add(UsernameChanged(value));
      },
      validator: (value) {
        final userName = Username.dirty(value!);
        final error = userName.validator(value);
        return userName.validationToString(error);
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

  Widget continueButton() {
    return AuthButton(
      label: 'Continue',
      light: false,
      flex: true,
      onPressed: () {
        bloc.add(const PageChanged(2, true));
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
