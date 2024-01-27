import 'package:carro_flutter_app/carro_dev.dart';
import 'package:carro_flutter_app/carro_prod.dart';
import 'package:carro_flutter_app/core/config/app_config.dart';
import 'package:carro_flutter_app/core/provider/view_model/theme_provider.dart';
import 'package:carro_flutter_app/core/theme/theme.dart';
import 'package:carro_flutter_app/modules/common/main_skeleton.dart';
import 'package:carro_flutter_app/modules/settings/settings_model.dart';
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: Provider.of<ThemeProvider>(context).getTheme,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const MainSkeleton(),
    );
  }
}
