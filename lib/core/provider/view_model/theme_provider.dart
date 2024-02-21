import 'package:carro_flutter_app/core/enums/app_icon.dart';
import 'package:carro_flutter_app/core/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';

class ThemeProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  ThemeMode _theme = SharedPrefs().isDarkThemePref == null
      ? ThemeMode.dark
      : SharedPrefs().isDarkThemePref == false
          ? ThemeMode.light
          : ThemeMode.dark;
  ThemeMode get getTheme => _theme;

  int get getSelectedIndex => _selectedIndex;

  AppIcon? currentIcon;

  void setSelectedIndex(int selectedIndex) {
    _selectedIndex = selectedIndex;
    notifyListeners();
  }

  void toggleTheme() {
    final isDark = _theme == ThemeMode.dark;
    if (isDark) {
      _theme = ThemeMode.light;
      SharedPrefs().isDarkThemeTogglePref();
      changeAppIcon(AppIcon.values.byName('light'));
    } else {
      _theme = ThemeMode.dark;
      SharedPrefs().isDarkThemeTogglePref();
      changeAppIcon(AppIcon.values.byName('dark'));
    }
    notifyListeners();
  }

  void changeAppIcon(AppIcon icon) async {
    try {
      // Check if the device supports alternate icons
      if (await FlutterDynamicIcon.supportsAlternateIcons) {
        // Change the icon
        await FlutterDynamicIcon.setAlternateIconName(icon.name,
            showAlert: false);
        //Reason for second setAlternateIconName is because only set twice can change app switcher icon
        await FlutterDynamicIcon.setAlternateIconName(icon.name,
            showAlert: false);
        // currentIcon = icon; // Update the currentIcon value
      }
      notifyListeners();
    } on PlatformException catch (_) {
      print('Failed to change app icon');
    }
  }
}
