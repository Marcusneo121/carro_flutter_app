import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _theme = ThemeMode.light;
  ThemeMode get getTheme => _theme;

  void toggleTheme() {
    final isDark = _theme == ThemeMode.dark;
    if (isDark) {
      _theme = ThemeMode.light;
    } else {
      _theme = ThemeMode.dark;
    }
    notifyListeners();
  }
}
