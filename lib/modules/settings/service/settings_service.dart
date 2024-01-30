import 'package:carro_flutter_app/modules/settings/entity/post.dart';
import 'package:dio/dio.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

final dio = Dio();

class SettingsService {
  static Future<List<Post>?> getPosts() async {
    try {
      Response<dynamic> response =
          await dio.get('https://jsonplaceholder.typicode.com/photos');

      if (response.data is List) {
        // return response.data.map<Post>((data) => Post.fromJson(data)).toList();
        List data = response.data as List;
        return data.map((e) => Post.fromJson(e)).take(100).toList();
      }
    } on DioException catch (e) {
      print(e.error);
    } catch (e) {
      throw e;
    }
  }
}
