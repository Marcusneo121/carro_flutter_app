import 'package:carro_flutter_app/core/constants/strings.dart';
import 'package:carro_flutter_app/core/models/lougout_response.dart';
import 'package:carro_flutter_app/core/models/user_session.dart';
import 'package:carro_flutter_app/core/network/api.dart';
import 'package:carro_flutter_app/core/utils/shared_prefs.dart';
import 'package:carro_flutter_app/modules/authentication/register/entity/email_username_checking_response.dart';
import 'package:carro_flutter_app/modules/authentication/register/entity/normal_api_response.dart';
import 'package:carro_flutter_app/modules/authentication/register/entity/register.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

final dio = DioFactory();

class AuthService {
  static Future<NormalApiResponse?> register(RegisterData data) async {
    try {
      Response<dynamic> response = await dio.post(
        url: '/register',
        data: {
          "isAdmin": data.isAdmin,
          "username": data.username,
          "email": data.email,
          "password": data.password,
          "first_name": data.firstName,
          "last_name": data.lastName,
          "address1": data.address1,
          "address2": data.address2 ?? "-",
          "address3": data.address3 ?? "-",
          "poscode": data.poscode,
          "city": data.city,
          "state": data.state,
          "age": data.age,
          "phone_number": data.phoneNumber,
          "date_of_birth": data.dateOfBirth?.toIso8601String(),
          "profile_image": data.profileImage ?? "-"
        },
        // queryParameters: {
        //   //can actually use toJSON in the RegisterData model, if available
        //   "isAdmin": false,
        //   "username": data.username,
        //   "email": data.email,
        //   "password": data.password,
        //   "first_name": data.firstName,
        //   "last_name": data.lastName,
        //   "address1": data.address1,
        //   "address2": data.address2,
        //   "address3": data.address3,
        //   "poscode": data.poscode,
        //   "city": data.city,
        //   "state": data.state,
        //   "age": data.age == null ? null : int.parse(data.age.toString()),
        //   "phone_number": data.phoneNumber,
        //   "date_of_birth": data.dateOfBirth,
        //   "profile_image": data.profileImage
        // },
      );
      return NormalApiResponse.fromJson(response.data);
    } on DioException catch (e) {
      DioErrorHelper().showDialog(e);
    } catch (e) {
      EasyLoading.showError('Error, please try again');
    }
  }

  static Future<UserSession?> login(String username, String password) async {
    try {
      Response<dynamic> response = await dio.post(
        url: '/login',
        data: {
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
  }

  static Future<LogoutResponse?> logout() async {
    try {
      Response<dynamic> response = await dio.post(
        url: '/logout',
      );
      return LogoutResponse.fromJson(response.data);
    } on DioException catch (e) {
      DioErrorHelper().showDialog(e);
      // EasyLoading.showError('Error logging out, please try again');
    } catch (e) {
      EasyLoading.showError('Error logging out, please try again');
    }
  }

  static Future<EmailUsernameCheckingResponse?> usernameChecking(
      {required String username}) async {
    try {
      Response<dynamic> response = await dio.post(
        url: '/register/checkUsername',
        data: {
          "username": username,
        },
      );

      return EmailUsernameCheckingResponse.fromJson(response.data);
    } on DioException catch (e) {
      DioErrorHelper().showDialog(e);
      // EasyLoading.showError('Error logging out, please try again');
    } catch (e) {
      EasyLoading.showError('Error, please try again');
    }
  }

  static Future<EmailUsernameCheckingResponse?> emailChecking(
      {required String email}) async {
    try {
      Response<dynamic> response = await dio.post(
        url: '/register/checkEmail',
        data: {
          "email": email,
        },
      );
      return EmailUsernameCheckingResponse.fromJson(response.data);
    } on DioException catch (e) {
      DioErrorHelper().showDialog(e);
      // EasyLoading.showError('Error logging out, please try again');
    } catch (e) {
      EasyLoading.showError('Error, please try again');
    }
  }
}
