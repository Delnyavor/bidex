import 'package:bidex/common/app_themes.dart';
import 'package:bidex/common/transitions/route_transitions.dart';
import 'package:bidex/features/auth/domain/usecases/sign_in.dart';
import 'package:bidex/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bidex/di/injection_container.dart';
import 'package:bidex/features/auth/presentation/pages/login_page.dart';
import 'package:bidex/features/auth/presentation/pages/registration_page.dart';
import 'package:bidex/features/scaffolding/presentation/bloc/navigation_bloc.dart/bloc/navigation_bloc.dart';
import 'package:bidex/features/scaffolding/presentation/pages/scaffolding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/login_bloc/login_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

//...
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(
            createUser: sl(),
            getUser: sl(),
            deleteUser: sl(),
            updateUser: sl(),
          ),
        ),
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(
            signIn: SignIn(sl()),
          ),
        ),
        BlocProvider<NavigationBloc>(
          create: (BuildContext context) => NavigationBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Bidex',
        theme: lightTheme,
        themeMode: ThemeMode.light,
        home: const Landing(),
      ),
    );
  }
}

class Landing extends StatelessWidget {
  const Landing({Key? key}) : super(key: key);
  void push(context) {
    Navigator.push(
      context,
      fadeInRoute(const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            push(context);
          },
          child: const Text('Click'),
        ),
      ),
    );
  }
}
