import 'package:carro_flutter_app/core/config/app_config.dart';
import 'package:carro_flutter_app/core/provider/view_model/theme_provider.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/utils/shared_prefs.dart';
import 'package:carro_flutter_app/main_init.dart';
import 'package:carro_flutter_app/modules/home/view_model/home_model.dart';
import 'package:carro_flutter_app/modules/settings/view_model/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(() => CarroRouter());
}

Future main() async {
  await dotenv.load(fileName: ".env");
  await SharedPrefs().init();
  setupLocator();
  // switch (dotenv.env['ENVIRONMENT']) {
  //   case 'Prod':
  //     AppConfig.init(Env.prod);
  //     break;
  //   case 'Dev':
  //     AppConfig.init(Env.dev);
  //     break;
  //   default:
  //     AppConfig.init(Env.dev);
  //     break;
  // }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: const CarroInit(),
    ),
  );
}
