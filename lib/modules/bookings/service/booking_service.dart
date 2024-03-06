import 'dart:math';

import 'package:carro_flutter_app/core/network/api.dart';
import 'package:carro_flutter_app/modules/authentication/register/entity/normal_api_response.dart';
import 'package:carro_flutter_app/modules/bookings/entity/booking.dart';
import 'package:carro_flutter_app/modules/bookings/entity/confrim_payment.dart';
import 'package:carro_flutter_app/modules/bookings/entity/make_payment_intent.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

final dio = DioFactory();

class BookingService {
  static Future<Bookings?> getBooking() async {
    // try {
    Response<dynamic> response = await dio.get(
      url: '/rent/bargain/user/guest',
    );

    return Bookings.fromJson(response.data);
    // } on DioException catch (e) {
    //   DioErrorHelper().showDialog(e);
    // } catch (e) {
    //   EasyLoading.showError('Error, please try again');
    // }
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

  static Future<NormalApiResponse?> updateBargaining(
      int bargainID, String actionType) async {
    try {
      Response<dynamic> response = await dio.patch(
        url: '/rent/bargain/guest/action',
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

  static Future<MakePaymentIntent?> makePaymentIntent({
    required String totalAmount,
    required int bargainID,
    required int rentalTansactionId,
  }) async {
    // try {
    Response<dynamic> response = await dio.post(
      url: '/payment/make-payment-intent',
      data: {
        "total_amount": totalAmount.toString(),
        "bargain_id": bargainID.toInt(),
        "rental_transaction_id": rentalTansactionId.toInt()
      },
    );
    return MakePaymentIntent.fromJson(response.data);
    // } on DioException catch (e) {
    //   DioErrorHelper().showDialog(e);
    // } catch (e) {
    //   EasyLoading.showError('Error, please try again');
    // }
  }

  static Future<ConfirmPayment?> confirmPayment({
    required int paymentTransactionId,
    required int bargainID,
    required int rentalTansactionId,
    required String stripeCustomerId,
  }) async {
    // try {
    if (paymentTransactionId == -1) {
      EasyLoading.showError('Error, please try again');
    } else {
      Response<dynamic> response = await dio.post(
        url: '/payment/confirm-payment',
        data: {
          "payment_transaction_id": paymentTransactionId.toString(),
          "bargain_id": bargainID.toInt(),
          "rental_transaction_id": rentalTansactionId.toInt(),
          "stripe_customer_id": stripeCustomerId.toString(),
        },
      );
      return ConfirmPayment.fromJson(response.data);
    }
    // } on DioException catch (e) {
    //   DioErrorHelper().showDialog(e);
    // } catch (e) {
    //   EasyLoading.showError('Error, please try again');
    // }
  }
}

// {
//     "name": "string",
//     "email": "string",
//     "total_amount": "string",
//     "bargain_id": "number",
//     "rental_transaction_id": "number"
// }
