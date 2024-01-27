import 'package:carro_flutter_app/core/config/app_config.dart';
import 'package:flutter/material.dart';

class CarroProd extends StatelessWidget {
  const CarroProd({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Text('Prod'),
            Text(AppConfig.config?.apiBaseUrl ?? ""),
          ],
        ),
      ),
    );
  }
}
