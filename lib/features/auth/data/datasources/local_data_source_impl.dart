import 'package:bidex/features/auth/data/datasources/local_data_source.dart';
import 'package:bidex/features/auth/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthSourceImpl extends LocalAuthSource {
  @override
  Future deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove(CacheKeys.isLoggedIn);
    await prefs.remove(CacheKeys.loggedUser);
    await prefs.remove(CacheKeys.refreshToken);
    await prefs.remove(CacheKeys.idToken);
  }

  @override
  Future<bool> isloggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(CacheKeys.isLoggedIn)!;
  }

  @override
  Future getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(CacheKeys.loggedUser);
  }

  @override
  Future saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool(CacheKeys.isLoggedIn, true);
    await prefs.setString(CacheKeys.loggedUser, user.email);
    await prefs.setString(CacheKeys.loggedId, user.id);
    await prefs.setString(CacheKeys.refreshToken, user.refreshToken);
    await prefs.setString(CacheKeys.idToken, user.idToken);
  }
}

class CacheKeys {
  static const String isLoggedIn = 'isLoggedIn';
  static const String loggedUser = 'loggedUser';
  static const String loggedId = 'loggedId';
  static const String idToken = 'idToken';
  static const String refreshToken = 'refreshToken';
}
