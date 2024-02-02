import 'package:carro_flutter_app/core/utils/shared_prefs.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  ThemeMode _theme = SharedPrefs().isDarkThemePref == null
      ? ThemeMode.dark
      : SharedPrefs().isDarkThemePref == false
          ? ThemeMode.light
          : ThemeMode.dark;
  ThemeMode get getTheme => _theme;

  int get getSelectedIndex => _selectedIndex;

  void setSelectedIndex(int selectedIndex) {
    _selectedIndex = selectedIndex;
    notifyListeners();
  }

  void toggleTheme() {
    final isDark = _theme == ThemeMode.dark;
    if (isDark) {
      _theme = ThemeMode.light;
      SharedPrefs().isDarkThemeTogglePref();
    } else {
      _theme = ThemeMode.dark;
      SharedPrefs().isDarkThemeTogglePref();
    }
    notifyListeners();
  }
}
