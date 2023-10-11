import 'package:bidex/features/auth/data/datasources/auth_data_source.dart';
import 'package:bidex/features/auth/data/datasources/auth_data_source_impl.dart';
import 'package:bidex/features/auth/data/datasources/firebase_auth_source.dart';
import 'package:bidex/features/auth/data/datasources/firebase_auth_source_impl.dart';
import 'package:bidex/features/auth/data/datasources/local_data_source.dart';
import 'package:bidex/features/auth/data/datasources/local_data_source_impl.dart';
import 'package:bidex/features/auth/data/repositories/auth_repository_implementation.dart';
import 'package:bidex/features/auth/domain/repositories/auth_repository.dart';
import 'package:bidex/features/auth/domain/usecases/create_user.dart';
import 'package:bidex/features/auth/domain/usecases/delete_user.dart';
import 'package:bidex/features/auth/domain/usecases/get_user.dart';
import 'package:bidex/features/auth/domain/usecases/sign_in.dart';
import 'package:bidex/features/auth/domain/usecases/update_user.dart';
import 'package:bidex/features/auth/domain/usecases/verify_user.dart';
import 'package:bidex/features/barter/data/datasources/barter_remote_data_source.dart';
import 'package:bidex/features/barter/data/datasources/barter_remote_data_source_impl.dart';
import 'package:bidex/features/barter/data/repositories/barter_repository_impl.dart';
import 'package:bidex/features/barter/domain/repositories/barter_repository.dart';
import 'package:bidex/features/barter/domain/usecases/create_barter.dart';
import 'package:bidex/features/barter/domain/usecases/delete_barter.dart';
import 'package:bidex/features/barter/domain/usecases/get_all_barters.dart';
import 'package:bidex/features/barter/domain/usecases/get_barter.dart';
import 'package:bidex/features/barter/domain/usecases/update_barter.dart';
import 'package:bidex/features/profile/data/datasources/user_posts_datasource.dart';
import 'package:bidex/features/profile/domain/usecases/get_user_posts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../features/auction/data/datasources/auction_remote_data_source.dart';
import '../features/auction/data/datasources/auction_remote_data_source_impl.dart';
import '../features/auction/data/repositories/auction_repository_impl.dart';
import '../features/auction/domain/repositories/auction_repository.dart';
import '../features/auction/domain/usecases/create_auction.dart';
import '../features/auction/domain/usecases/delete_auction.dart';
import '../features/auction/domain/usecases/get_all_auctions.dart';
import '../features/auction/domain/usecases/get_auction.dart';
import '../features/auction/domain/usecases/update_auction.dart';
import '../features/giftings/data/datasources/gift_remote_data_source.dart';
import '../features/giftings/data/datasources/gift_remote_data_source_impl.dart';
import '../features/giftings/data/repositories/gift_repository_impl.dart';
import '../features/giftings/domain/repositories/gift_repository.dart';
import '../features/giftings/domain/usecases/create_gift.dart';
import '../features/giftings/domain/usecases/delete_gift.dart';
import '../features/giftings/domain/usecases/get_all_barters.dart';
import '../features/giftings/domain/usecases/get_gift.dart';
import '../features/giftings/domain/usecases/update_gift.dart';
import '../features/profile/data/datasources/user_posts_datasource_impl.dart';
import '../features/profile/data/repositories/user_post_repository_impl.dart';
import '../features/profile/domain/repositories/user_post_repository.dart';

final sl = GetIt.instance;
Future<void> initDependencies() async {
  initFeatures();
  await initExternal();
}

void initFeatures() {
  sl.registerLazySingleton(() => http.Client);
  initAuthFeature();
  initAuctionsFeature();
  initBarterFeature();
  initGiftingsFeature();
  initProfileFeature();
}

//
//
//
//
//
// INITIALISE AUTH
void initAuthFeature() {
  sl.registerLazySingleton(() => CreateUser(sl()));
  sl.registerLazySingleton(() => DeleteUser(sl()));
  sl.registerLazySingleton(() => GetUser(sl()));
  sl.registerLazySingleton(() => UpdateUser(sl()));
  sl.registerLazySingleton(() => SignIn(sl()));
  sl.registerLazySingleton(() => Verify(sl()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImplementation(
      authDataSource: sl(),
      firebaseAuthDataSource: sl(),
      localAuthSource: sl()));

  sl.registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImpl(firebaseDatabase: sl()));
  sl.registerLazySingleton<LocalAuthSource>(() => LocalAuthSourceImpl());

  sl.registerLazySingleton<FirebaseAuthDataSource>(
      () => FirebaseAuthDataSourceImpl(firebaseAuth: sl()));
}

//
//
//
//
// INITIALISE AUCTIONS
void initAuctionsFeature() {
  sl.registerLazySingleton<AuctionRemoteDataSource>(
      () => AuctionRemoteDataSourceImpl());

  sl.registerLazySingleton<AuctionRepository>(
      () => AuctionRepositoryImpl(dataSource: sl<AuctionRemoteDataSource>()));

  sl.registerLazySingleton(() => GetAllAuctions(repository: sl()));
  sl.registerLazySingleton(() => GetAuction(repository: sl()));
  sl.registerLazySingleton(() => CreateAuction(repository: sl()));
  sl.registerLazySingleton<UpdateAuction>(
      () => UpdateAuction(repository: sl()));
  sl.registerLazySingleton(() => DeleteAuction(repository: sl()));
}

//
//
//
//
// INITIALISE BARTERS
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

//
//
//
//
// INITIALISE GIFTINGS
void initGiftingsFeature() {
  sl.registerLazySingleton<GiftRemoteDataSource>(
      () => GiftRemoteDataSourceImpl());

  sl.registerLazySingleton<GiftRepository>(
      () => GiftRepositoryImpl(dataSource: sl()));

  sl.registerLazySingleton(() => GetAllGifts(repository: sl()));
  sl.registerLazySingleton(() => GetGift(repository: sl()));
  sl.registerLazySingleton(() => CreateGift(repository: sl()));
  sl.registerLazySingleton<UpdateGift>(() => UpdateGift(repository: sl()));
  sl.registerLazySingleton(() => DeleteGift(repository: sl()));
}

//
//
//
//
// INITIALISE PROFILE FEATURE
void initProfileFeature() {
  sl.registerLazySingleton<UserPostsRemoteDataSource>(
      () => UserPostsDataSourceImpl());

  sl.registerLazySingleton<UserPostRepository>(
      () => UserPostRepositoryImpl(dataSource: sl()));

  sl.registerLazySingleton(() => GetUserPosts(repository: sl()));
  // sl.registerLazySingleton(() => GetGift(repository: sl()));
  // sl.registerLazySingleton(() => CreateGift(repository: sl()));
  // sl.registerLazySingleton<UpdateGift>(() => UpdateGift(repository: sl()));
  // sl.registerLazySingleton(() => DeleteGift(repository: sl()));
}

//
//
//
//
// INITIALISE EXTERNAL DEPENDENCIES
Future<void> initExternal() async {
  await Firebase.initializeApp();
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseDatabase.instance);
  sl.registerLazySingleton(() async => await SharedPreferences.getInstance());
}
