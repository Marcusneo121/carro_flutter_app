import 'package:carro_flutter_app/core/constants/strings.dart';
import 'package:carro_flutter_app/core/models/user_session.dart';
import 'package:carro_flutter_app/core/utils/shared_prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioErrorHelper {
  showDialog(DioException e) {
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout) {
      EasyLoading.dismiss();
      EasyLoading.showError(
          'Connection Error. Please check internet connection.');
    }

    if (e.response != null) {
      switch (e.response?.statusCode) {
        case 422: //unprocessable entity
          EasyLoading.showError('Something went wrong, Please try again.');
          break;
        case 404: //Not found
          EasyLoading.showError(
              e.response?.data['message'].toString() ?? "Error");
          break;
        case 401: //Not found
          EasyLoading.showError('Something went wrong, Please try again.');
          break;
        default:
      }
    }
  }
}

class DioFactory {
  Dio dio = Dio();
  SharedPrefs shapref = SharedPrefs();
  // Dio getDio() {
  //   Map<String, String> headers = {
  //     CONTENT_TYPE: APPLICATION_JSON,
  //     ACCEPT: APPLICATION_JSON,
  //     AUTHORIZATION:
  //         'Bearer ${shapref.userSessionData.token?.token.toString()}',
  //     DEFAULT_LANGUAGE: DEFAULT_LANGUAGE
  //   };

  //   dio.options = BaseOptions(
  //     baseUrl: BASE_URL,
  //     headers: headers,
  //     // receiveTimeout: Constants.apiTimeOut,
  //     // sendTimeout: Constants.apiTimeOut,
  //   );
  //   return dio;
  // }

  Future<Response<dynamic>> get(
      {required String url,
      Map<String, dynamic>? queryParameters,
      Object? data,
      bool useOwnBaseURL = false}) async {
    Response<dynamic> response = await dio.get(
      useOwnBaseURL == false ? BASE_URL + url : url,
      queryParameters: queryParameters,
      data: data,
      options: Options(headers: {
        CONTENT_TYPE: APPLICATION_JSON,
        ACCEPT: APPLICATION_JSON,
        AUTHORIZATION:
            'Bearer ${shapref.userSessionData.token?.token.toString()}',
        DEFAULT_LANGUAGE: DEFAULT_LANGUAGE
      }),
    );

    return response;
  }

  Future<Response<dynamic>> post(
      {required String url,
      Map<String, dynamic>? queryParameters,
      Object? data,
      bool useOwnBaseURL = false}) async {
    late Options optionData;
    if (shapref.getStringUserSessionData == null) {
      optionData = Options(headers: {
        CONTENT_TYPE: APPLICATION_JSON,
        ACCEPT: APPLICATION_JSON,
        DEFAULT_LANGUAGE: DEFAULT_LANGUAGE
      });
    } else {
      optionData = Options(headers: {
        CONTENT_TYPE: APPLICATION_JSON,
        ACCEPT: APPLICATION_JSON,
        AUTHORIZATION:
            'Bearer ${shapref.userSessionData.token?.token.toString() ?? ""}',
        DEFAULT_LANGUAGE: DEFAULT_LANGUAGE
      });
    }

    Response<dynamic> response = await dio.post(
      useOwnBaseURL == false ? BASE_URL + url : url,
      queryParameters: queryParameters,
      data: data,
      options: optionData,
    );

    return response;
  }
}
