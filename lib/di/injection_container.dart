import 'package:bidex/features/auth/data/datasources/auth_data_source.dart';
import 'package:bidex/features/auth/data/datasources/auth_data_source_impl.dart';
import 'package:bidex/features/auth/data/datasources/firebase_auth_source.dart';
import 'package:bidex/features/auth/data/datasources/firebase_auth_source_impl.dart';
import 'package:bidex/features/auth/data/repositories/auth_repository_implementation.dart';
import 'package:bidex/features/auth/domain/repositories/auth_repository.dart';
import 'package:bidex/features/auth/domain/usecases/create_user.dart';
import 'package:bidex/features/auth/domain/usecases/delete_user.dart';
import 'package:bidex/features/auth/domain/usecases/get_user.dart';
import 'package:bidex/features/auth/domain/usecases/sign_in.dart';
import 'package:bidex/features/auth/domain/usecases/update_user.dart';
import 'package:bidex/features/barter/data/datasources/barter_remote_data_source.dart';
import 'package:bidex/features/barter/data/datasources/barter_remote_data_source_impl.dart';
import 'package:bidex/features/barter/data/repositories/barter_repository_impl.dart';
import 'package:bidex/features/barter/domain/repositories/barter_repository.dart';
import 'package:bidex/features/barter/domain/usecases/create_barter.dart';
import 'package:bidex/features/barter/domain/usecases/delete_barter.dart';
import 'package:bidex/features/barter/domain/usecases/get_all_barters.dart';
import 'package:bidex/features/barter/domain/usecases/get_barter.dart';
import 'package:bidex/features/barter/domain/usecases/update_barter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;
Future<void> initDependencies() async {
  initFeatures();
  await initExternal();
}

void initFeatures() {
  sl.registerLazySingleton(() => http.Client);
  initAuthFeature();
  initBarterFeature();
}

void initAuthFeature() {
  sl.registerLazySingleton(() => CreateUser(sl()));
  sl.registerLazySingleton(() => DeleteUser(sl()));
  sl.registerLazySingleton(() => GetUser(sl()));
  sl.registerLazySingleton(() => UpdateUser(sl()));
  sl.registerLazySingleton(() => SignIn(sl()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImplementation(
        authDataSource: sl(),
        firebaseAuthDataSource: sl(),
      ));

  sl.registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImpl(firebaseDatabase: sl()));

  sl.registerLazySingleton<FirebaseAuthDataSource>(
      () => FirebaseAuthDataSourceImpl(firebaseAuth: sl()));
}

void initBarterFeature() {
  sl.registerLazySingleton<BarterRemoteDataSource>(
      () => BarterRemoteDataSourceImpl());

  sl.registerLazySingleton<BarterRepository>(
      () => BarterRepositoryImpl(dataSource: sl()));

  sl.registerLazySingleton(() => GetAllBarters(repository: sl()));
  sl.registerLazySingleton(() => GetBarter(repository: sl()));
  sl.registerLazySingleton(() => CreateBarter(repository: sl()));
  sl.registerLazySingleton<UpdateBarter>(() => UpdateBarter(repository: sl()));
  sl.registerLazySingleton(() => DeleteBarter(repository: sl()));
}

Future<void> initExternal() async {
  await Firebase.initializeApp();
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseDatabase.instance);
}
