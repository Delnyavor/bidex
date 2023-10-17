import 'package:bidex/features/auth/data/datasources/local_data_source.dart';
import 'package:bidex/features/auth/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthSourceImpl extends LocalAuthSource {
  @override
  Future deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool(CacheKeys.isLoggedIn, false);
    await prefs.remove(CacheKeys.loggedUser);
    await prefs.remove(CacheKeys.refreshToken);
    await prefs.remove(CacheKeys.idToken);
    await prefs.remove(CacheKeys.loggedId);
    await prefs.remove(CacheKeys.firstName);
    await prefs.remove(CacheKeys.lastName);
    await prefs.remove(CacheKeys.username);
    await prefs.remove(CacheKeys.phone);
    await prefs.remove(CacheKeys.photo);
  }

  @override
  Future<bool> isloggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(CacheKeys.isLoggedIn) ?? false;
  }

  @override
  Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return User(
        id: prefs.getString(CacheKeys.loggedId) ?? '',
        email: prefs.getString(CacheKeys.loggedUser) ?? '',
        photo: prefs.getString(CacheKeys.photo) ?? '',
        firstName: prefs.getString(CacheKeys.firstName) ?? '',
        lastName: prefs.getString(CacheKeys.lastName) ?? '',
        username: prefs.getString(CacheKeys.username) ?? '',
        phone: prefs.getString(CacheKeys.phone) ?? '',
        refreshToken: prefs.getString(CacheKeys.refreshToken) ?? '',
        idToken: prefs.getString(CacheKeys.idToken) ?? '');
  }

  @override
  Future saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool(CacheKeys.isLoggedIn, true);
    await prefs.setString(CacheKeys.loggedUser, user.email);
    await prefs.setString(CacheKeys.loggedId, user.id);
    await prefs.setString(CacheKeys.refreshToken, user.refreshToken);
    await prefs.setString(CacheKeys.idToken, user.idToken);
    await prefs.setString(CacheKeys.username, user.username);
    await prefs.setString(CacheKeys.firstName, user.firstName);
    await prefs.setString(CacheKeys.lastName, user.lastName);
    await prefs.setString(CacheKeys.phone, user.phone);
    await prefs.setString(CacheKeys.photo, user.photo);
  }
}

class CacheKeys {
  static const String isLoggedIn = 'isLoggedIn';
  static const String loggedUser = 'loggedUser';
  static const String loggedId = 'loggedId';
  static const String idToken = 'idToken';
  static const String refreshToken = 'refreshToken';
  static const String username = 'username';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String phone = 'phone';
  static const String photo = 'photo';
}
