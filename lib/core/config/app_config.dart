import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Env { prod, dev }

class AppConfig {
  Env? env;
  String? apiBaseUrl;

  AppConfig({this.env, this.apiBaseUrl});

  static AppConfig? config;

  static init(Env? env) {
    String? envStr;
    switch (env) {
      case Env.prod:
        envStr = "Prod";
        break;
      case Env.dev:
        envStr = "Dev";
        break;
      default:
        envStr = "Dev";
    }
    var conf = domains[envStr];
    AppConfig.config = AppConfig(
      env: env,
      apiBaseUrl: conf['carroBaseUrl'],
    );
  }

  String? getBaseUrl() {
    return apiBaseUrl;
  }

  Env? getEnv() {
    return env;
  }
}

Map<String, dynamic> domains = {
  "Dev": {
    "carroBaseUrl": dotenv.env['CARRO_API_BASE_URL_DEV'],
  },
  "Prod": {
    "carroBaseUrl": dotenv.env['CARRO_API_BASE_URL_PROD'],
  },
};
