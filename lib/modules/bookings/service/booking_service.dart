import 'package:carro_flutter_app/core/network/api.dart';
import 'package:carro_flutter_app/modules/authentication/register/entity/normal_api_response.dart';
import 'package:carro_flutter_app/modules/bookings/entity/booking.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

final dio = DioFactory();

class BookingService {
  static Future<Bookings?> getBooking() async {
    try {
      Response<dynamic> response = await dio.get(
        url: '/rent/bargain/user/guest',
      );

      return Bookings.fromJson(response.data);
    } on DioException catch (e) {
      DioErrorHelper().showDialog(e);
    } catch (e) {
      EasyLoading.showError('Error, please try again');
    }
  }

  static Future<NormalApiResponse?> bargaining(
      int bargainID, String bargainAmount) async {
    try {
      Response<dynamic> response = await dio.post(
        url: '/rent/bargaining',
        data: {
          "bargain_id": bargainID,
          "bargain_amount": bargainAmount.toString(),
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
