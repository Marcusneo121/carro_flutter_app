import 'package:carro_flutter_app/core/config/app_config.dart';
import 'package:flutter/material.dart';

class CarroDev extends StatelessWidget {
  const CarroDev({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Text('Dev'),
            Text(AppConfig.config?.apiBaseUrl ?? ""),
          ],
        ),
      ),
    );
  }
}
