import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/custom_themes/text_theme.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    // brightness: Brightness.light,
    // primaryColor: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFFF1F1F1),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    textTheme: TTextTheme.lightTextTheme,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      // backgroundColor: const Color(0xFFFFFBFE),
      // selectedItemColor: const Color(0xFF073FFF).withOpacity(0.5),
      backgroundColor: Color(0xFF2E2E2E),
      selectedItemColor: Color(0xFF7879F1),
      unselectedItemColor: Color(0xFFC4C4C4),
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: const Color(0xFF7620FF),
      onPrimary: Colors.black,
      secondary: const Color(0xFF073FFF).withOpacity(0.15),
      onSecondary: Colors.black,
      primaryContainer: const Color(0xFFE6EBFF),
      error: Colors.black,
      onError: Colors.white,
      background: const Color(0xFFF1F1F1),
      onBackground: Colors.black,
      surface: Colors.pink,
      onSurface: Colors.black38,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: CarroColors.iconBackgroundColor,
      contentPadding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 19.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: CarroColors.list_item_color, width: 3.0),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF7879F1), width: 3.0),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    // brightness: Brightness.dark,
    // primaryColor: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFF0C0120),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    textTheme: TTextTheme.darkTextTheme,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF0C0120),
      selectedItemColor: const Color(0xFF7620FF),
      unselectedItemColor: Colors.grey.shade400,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF7620FF),
      onPrimary: Colors.white,
      secondary: Color(0xFF272036),
      onSecondary: Color(0xFFBDBDBD),
      primaryContainer: Color(0xFF443B59),
      error: Colors.black,
      onError: Colors.white,
      background: Color(0xFF0C0120),
      onBackground: Color(0xFFBDBDBD),
      surface: Colors.pink,
      onSurface: Color(0xFF0C0120),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF252525),
      contentPadding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 19.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF444444), width: 3.0),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF7879F1), width: 3.0),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
    ),
  );
}
