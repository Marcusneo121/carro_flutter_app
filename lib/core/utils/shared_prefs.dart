import 'dart:convert';
import 'package:carro_flutter_app/core/constants/strings.dart';
import 'package:carro_flutter_app/core/models/user_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

// final sharedPrefs = SharedPrefs();

class SharedPrefs {
  // late final SharedPreferences _sharedPrefs;
  // Future<void> init() async {
  //   _sharedPrefs = await SharedPreferences.getInstance();
  // }

  late final SharedPreferences _sharedPrefs;
  static final SharedPrefs _instance = SharedPrefs._internal();
  factory SharedPrefs() => _instance;
  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
    // _sharedPrefs.setBool(carroThemeIsDark, false);
  }

  SharedPreferences get sharedPrefInstance => _sharedPrefs;

  set setSessionData(UserSession data) {
    _sharedPrefs.setString(sessionData, jsonEncode(data));
  }

  removeSessionData() {
    _sharedPrefs.remove(sessionData);
  }

  String? get getStringUserSessionData => _sharedPrefs.getString(sessionData);

  UserSession get userSessionData => UserSession.fromJson(
      jsonDecode(_sharedPrefs.getString(sessionData) ?? ""));

  isDarkThemeTogglePref() {
    if (_sharedPrefs.getBool(carroThemeIsDark) == false ||
        _sharedPrefs.getBool(carroThemeIsDark) == null) {
      _sharedPrefs.setBool(carroThemeIsDark, true);
    } else {
      _sharedPrefs.setBool(carroThemeIsDark, false);
    }
  }

  bool? get isDarkThemePref => _sharedPrefs.getBool(carroThemeIsDark);

  // String get token => _sharedPrefs.getString(sessionToken) ?? "";

  // set token(String value) {
  //   _sharedPrefs.setString(sessionToken, value);
  // }
}
