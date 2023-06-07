import 'package:bidex/common/app_themes.dart';
import 'package:bidex/common/transitions/route_transitions.dart';
import 'package:bidex/features/auction/presentation/bloc/auction_bloc.dart';
import 'package:bidex/features/auth/domain/usecases/sign_in.dart';
import 'package:bidex/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bidex/di/injection_container.dart';
import 'package:bidex/features/barter/presentation/bloc/barter_bloc.dart';
import 'package:bidex/features/auth/presentation/pages/onboarding_page.dart';
import 'package:bidex/features/scaffolding/presentation/bloc/navigation_bloc.dart/bloc/navigation_bloc.dart';
import 'package:bidex/features/scaffolding/presentation/pages/scaffolding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/login_bloc/login_bloc.dart';
import 'features/direct_messages/presentation/bloc/chat_bloc.dart';
import 'features/giftings/presentation/bloc/giftings_bloc.dart';

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
            verify: sl(),
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
        BlocProvider<BarterBloc>(
          create: (BuildContext context) => BarterBloc(
            createBarter: sl(),
            getAllBarters: sl(),
            getBarter: sl(),
            updateBarter: sl(),
            deleteBarter: sl(),
          ),
        ),
        BlocProvider<GiftingsBloc>(
          create: (BuildContext context) => GiftingsBloc(
            createGift: sl(),
            getAllGifts: sl(),
            getGift: sl(),
            updateGift: sl(),
            deleteGift: sl(),
          ),
        ),
        BlocProvider<AuctionBloc>(
          create: (context) => AuctionBloc(
            createAuction: sl(),
            getAllAuctions: sl(),
            getAuction: sl(),
            updateAuction: sl(),
            deleteAuction: sl(),
          ),
        ),
        BlocProvider<ChatBloc>(
          create: (context) => ChatBloc(),
        )
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
      fadeInRoute(const PageScaffolding()),
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
