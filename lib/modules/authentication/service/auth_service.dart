import 'package:carro_flutter_app/core/constants/strings.dart';
import 'package:carro_flutter_app/core/models/lougout_response.dart';
import 'package:carro_flutter_app/core/models/user_session.dart';
import 'package:carro_flutter_app/core/network/api.dart';
import 'package:carro_flutter_app/core/utils/shared_prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

final dio = DioFactory();

class AuthService {
  static Future<UserSession?> login(String username, String password) async {
    try {
      Response<dynamic> response = await dio.post(
        url: '/login',
        queryParameters: {
          "username": username,
          "password": password,
        },
      );
      return UserSession.fromJson(response.data);
    } on DioException catch (e) {
      DioErrorHelper().showDialog(e);
    } catch (e) {
      EasyLoading.showError('Error, please try again');
    }
    return null;
  }

  static Future<LogoutResponse?> logout() async {
    try {
      Response<dynamic> response = await dio.post(
        url: '/logout',
        // options: Options(headers: {
        //   "authorization":
        //       'Bearer MTk.VaQeUSLv89rC4noAYBItzV4DELqktidXhGuQsjlwIDaVAonL6oxjSfXIqmAM'
        // }),
      );
      return LogoutResponse.fromJson(response.data);
    } on DioException catch (e) {
      print(e);
      DioErrorHelper().showDialog(e);
      // EasyLoading.showError('Error logging out, please try again');
    } catch (e) {
      EasyLoading.showError('Error logging out, please try again');
    }
    return null;
  }
}
