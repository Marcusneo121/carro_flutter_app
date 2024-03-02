import 'package:carro_flutter_app/core/provider/view_model/theme_provider.dart';
import 'package:carro_flutter_app/modules/home/entity/car.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarroColors {
  /// Black Color
  static const black_1 = Color(0xFFFAFAFA);
  static const black_2 = Color(0xFFF2F2F2);

  /// Border Light
  static const black_3 = Color(0xFFEDEDED);

  /// Border Default
  static const black_4 = Color(0xFFD3D3D3);

  /// Radio, Checkbox Border
  static const black_5 = Color(0xFFADADAD);

  /// Label Text
  static const black_6 = Color(0xFF7A7A7A);

  /// Content
  static const black_7 = Color(0xFF3A3A3A);

  /// Title
  static const black_8 = Color(0xFF191919);

  /// Label Value
  static const black_9 = Color(0xFF292929);

  /// background Value
  static const black_10 = Color(0xFF000000);

  static const list_item_color = Color(0xFFDAE2FF);

  static const list_item_color_dark = Color(0xFF272036);

  static const scaffoldBackgroundColor = Color(0xFFF1F1F1);

  static const scaffoldBackgroundColorDark = Color(0xFF0C0120);

  static const iconColor = Colors.black;

  static final iconColorDark = Colors.grey.shade400;

  static const iconBackgroundColor = Colors.white;

  static const iconBackgroundColorDark = Color(0xFF272036);

  static const textInputColor = Colors.grey;

  static final textInputColorDark = Colors.grey.shade400;

  static final registerHeadlineColor = Colors.black.withOpacity(1.0);

  static const registerHeadlineColorDark = Colors.white;

  static const fail = Color(0xFFFF333A);
  static const failDark = Color.fromARGB(255, 198, 35, 41);

  static const primayColor = Color(0xFF7620FF);

  // static const primayColorLight = Color.fromARGB(255, 169, 116, 255);

  static const carViewListItemBackgroundColor =
      Color.fromARGB(255, 249, 248, 248);
  static const carViewListItemBackgroundColorDark =
      Color.fromARGB(255, 42, 35, 58);

  /// Dark Theme Color Map
  static final Map<Color, Color> _darkColor = {
    CarroColors.black_1: CarroColors.black_1,
    CarroColors.black_8: Colors.white,
    CarroColors.list_item_color: CarroColors.list_item_color_dark,
    CarroColors.scaffoldBackgroundColor:
        CarroColors.scaffoldBackgroundColorDark,
    CarroColors.iconColor: CarroColors.iconColorDark,
    CarroColors.iconBackgroundColor: CarroColors.iconBackgroundColorDark,
    CarroColors.textInputColor: CarroColors.textInputColorDark,
    CarroColors.registerHeadlineColor: CarroColors.registerHeadlineColorDark,
    CarroColors.fail: CarroColors.failDark,
    // CarroColors.primayColorLight: CarroColors.primayColorDark,
    CarroColors.carViewListItemBackgroundColor:
        CarroColors.carViewListItemBackgroundColorDark,
  };

  static bool isDarkTheme(BuildContext context) {
    return Brightness.dark == Theme.of(context).brightness;
  }

  /// Standard way to set Color.
  static getColor(BuildContext context, Color color,
      {bool changedOnDark = true, Color? darkColor}) {
    // ThemeMode brightness = context.read<ThemeProvider>().getTheme;
    // return brightness == ThemeMode.dark ? _darkColor[color] : color;

    // return (brightness == Brightness.dark && changedOnDark)
    //     ? darkColor ?? _darkColor[color] ?? color
    //     : color;
    Brightness brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? darkColor ?? _darkColor[color] ?? color
        : color;
  }
}
