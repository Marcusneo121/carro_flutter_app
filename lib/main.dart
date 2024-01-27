import 'package:carro_flutter_app/core/config/app_config.dart';
import 'package:carro_flutter_app/core/provider/view_model/theme_provider.dart';
import 'package:carro_flutter_app/main_init.dart';
import 'package:carro_flutter_app/modules/settings/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  switch (dotenv.env['ENVIRONMENT']) {
    case 'Prod':
      AppConfig.init(Env.prod);
      break;
    case 'Dev':
      AppConfig.init(Env.dev);
      break;
    default:
      AppConfig.init(Env.dev);
      break;
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
      ],
      child: const CarroInit(),
    ),
  );
}
