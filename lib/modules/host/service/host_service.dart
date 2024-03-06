import 'package:carro_flutter_app/core/network/api.dart';
import 'package:carro_flutter_app/modules/authentication/register/entity/normal_api_response.dart';
import 'package:carro_flutter_app/modules/bookings/entity/booking.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

final dio = DioFactory();

class HostService {
  static Future<Bookings?> getHosting() async {
    // try {
    Response<dynamic> response = await dio.get(
      url: '/rent/bargain/user/host',
    );

    return Bookings.fromJson(response.data);
    // } on DioException catch (e) {
    //   DioErrorHelper().showDialog(e);
    // } catch (e) {
    //   EasyLoading.showError('Error, please try again');
    // }
  }

  static Future<NormalApiResponse?> updateBargaining(
      int bargainID, String actionType) async {
    try {
      Response<dynamic> response = await dio.patch(
        url: '/rent/bargain/host/action',
        data: {
          "action_type": actionType.toString(),
          "bargain_id": bargainID,
        },
      );
      return NormalApiResponse.fromJson(response.data);
    } on DioException catch (e) {
      DioErrorHelper().showDialog(e);
    } catch (e) {
      EasyLoading.showError('Error, please try again');
    }
  }
}
