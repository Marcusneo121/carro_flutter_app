import 'package:carro_flutter_app/carro_dev.dart';
import 'package:carro_flutter_app/carro_prod.dart';
import 'package:carro_flutter_app/core/config/app_config.dart';
import 'package:carro_flutter_app/core/provider/view_model/theme_provider.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/theme.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/common/carro_splashscreen.dart';
import 'package:carro_flutter_app/modules/common/main_skeleton.dart';
import 'package:carro_flutter_app/modules/settings/view_model/settings_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class CarroInit extends StatelessWidget {
  const CarroInit({super.key});

  @override
  Widget build(BuildContext context) {
    // Env? appStaging = AppConfig.config?.env;
    // switch (appStaging) {
    //   case Env.prod:
    //     return const CarroProd();
    //   case Env.dev:
    //     return const CarroDev();
    //   default:
    //     return const CarroDev();
    // }

    // return ScreenUtilInit(
    //   designSize: const Size(411, 731),
    //   minTextAdapt: true,
    //   splitScreenMode: true,
    //   builder: (_, child) => MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     themeMode: Provider.of<ThemeProvider>(context).getTheme,
    //     theme: AppTheme.lightTheme,
    //     darkTheme: AppTheme.darkTheme,
    //     home: const MainSkeleton(),
    //   ),
    // );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: Provider.of<ThemeProvider>(context).getTheme,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      navigatorKey: locator<CarroRouter>().navigatoryKey,
      onGenerateRoute: locator<CarroRouter>().generateRoute,
      //home: const MainSkeleton(),
      home: const CarroSplashscreen(),
      builder: EasyLoading.init(),
    );
  }
}
