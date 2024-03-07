import 'package:carro_flutter_app/core/network/api.dart';
import 'package:carro_flutter_app/modules/home/entity/car.dart';
import 'package:carro_flutter_app/modules/settings/entity/post.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

final dio = DioFactory();

class HomeService {
  static Future<List<Post>?> getPosts() async {
    //try {
    Response<dynamic> response = await dio.get(
      url: 'https://jsonplaceholder.typicode.com/photos',
      useOwnBaseURL: true,
    );

    if (response.data is List) {
      // return response.data.map<Post>((data) => Post.fromJson(data)).toList();
      List data = response.data as List;
      return data.map((e) => Post.fromJson(e)).take(100).toList();
    }

    //return null;
    // } catch (e) {
    //   return Future.error('Something went wrong');
    // }
  }

  static Future<Cars?> getCars() async {
    //try {
    Response<dynamic> response = await dio.get(
      url: '/car',
    );

    return Cars.fromJson(response.data);

    // var responseData = response.data['data'];
    // if (responseData is List) {
    //   // return response.data.map((e) => Car.fromJson(e)).toList();
    //   List data = responseData;
    //   return data.map((e) => Car.fromJson(e)).toList();
    // }
    // } on DioException catch (e) {
    //   DioErrorHelper().showDialog(e);
    //   return null;
    // } catch (e) {
    //   EasyLoading.showError('Error, please try again');
    //   return null;
    // }
  }
}
