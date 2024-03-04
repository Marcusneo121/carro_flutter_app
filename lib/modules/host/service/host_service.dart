import 'package:carro_flutter_app/core/network/api.dart';
import 'package:carro_flutter_app/modules/bookings/entity/booking.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

final dio = DioFactory();

class HostService {
  static Future<Bookings?> getHosting() async {
    try {
      Response<dynamic> response = await dio.get(
        url: '/rent/bargain/user/host',
      );

      return Bookings.fromJson(response.data);
    } on DioException catch (e) {
      DioErrorHelper().showDialog(e);
    } catch (e) {
      EasyLoading.showError('Error, please try again');
    }
  }
}
