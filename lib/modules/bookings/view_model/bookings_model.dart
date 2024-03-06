import 'package:carro_flutter_app/core/enums/enums.dart';
import 'package:carro_flutter_app/core/provider/view_model/theme_provider.dart';
import 'package:carro_flutter_app/core/provider/view_state_model.dart';
import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/authentication/register/entity/normal_api_response.dart';
import 'package:carro_flutter_app/modules/bookings/entity/booking.dart';
import 'package:carro_flutter_app/modules/bookings/entity/make_payment_intent.dart';
import 'package:carro_flutter_app/modules/bookings/service/booking_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BookingsModel extends ViewStateModel {
  Bookings? _bookings;
  List<Booking> get getBookingList => _bookings?.data ?? [];
  List<String> _imageList = [];

  List<String> get getImageList => _imageList;

  MakePaymentIntent? makePaymentIntentResponse;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  BookingsModel() {
    //call api here initializ
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await init();
    });
  }

  init() async {
    setBusy();
    try {
      List response = await Future.wait([
        BookingService.getBooking(),
      ]);

      if (response[0] != null) {
        _bookings = response[0];
      }

      print("My bookings length ${getBookingList.length}");
      refreshController.refreshCompleted();
      setIdle();
    } catch (e, s) {
      refreshController.refreshFailed();
      setError(e, s);
    }
  }

  bargaining(
      {required int? bargainID,
      required String bargainAmount,
      required BuildContext context}) async {
    setBusy();
    EasyLoading.show(dismissOnTap: false);
    if (bargainID != null) {
      NormalApiResponse? carBookingResponse = await BookingService.bargaining(
        bargainID, //should be available
        bargainAmount,
      );
      if (carBookingResponse != null) {
        EasyLoading.showSuccess("Your booking price is saved");
        await init();
        locator<CarroRouter>().navigateToAndRemoveUntil(CommonRoute.homePage);
        context.read<ThemeProvider>().setSelectedIndex(1);
      }
    } else {
      EasyLoading.showError(
        "Something went wrong, please try again.",
        duration: const Duration(
          seconds: 3,
        ),
      );
    }
  }

  acceptRejectBargain(
      {required int? bargainID,
      required GuestAction hostAction,
      required BuildContext context}) async {
    setBusy();
    EasyLoading.show(dismissOnTap: false);
    if (bargainID != null) {
      NormalApiResponse? carHostActionResponse =
          await BookingService.updateBargaining(
        bargainID, //should be available
        hostAction == GuestAction.accept ? 'accept' : 'reject',
      );
      if (carHostActionResponse != null) {
        if (hostAction == GuestAction.accept) {
          EasyLoading.showSuccess("You had accepted the offer.");
        } else {
          EasyLoading.showSuccess("You had rejected the offer.");
        }

        await init();
        locator<CarroRouter>().navigateToAndRemoveUntil(CommonRoute.homePage);
        context.read<ThemeProvider>().setSelectedIndex(1);
      }
    } else {
      EasyLoading.showError(
        "Something went wrong, please try again.",
        duration: const Duration(
          seconds: 3,
        ),
      );
    }
  }

  Future<void> initPaymentSheet({
    required String totalAmount,
    required int bargainID,
    required int rentalTansactionId,
    required Booking bookingData,
  }) async {
    EasyLoading.show(status: "Initializing Payment...");

    if (bargainID == -1 || rentalTansactionId == -1) {
      EasyLoading.showError("Something went wrong, please try again");
    } else {
      makePaymentIntentResponse = await BookingService.makePaymentIntent(
        totalAmount: totalAmount,
        bargainID: bargainID,
        rentalTansactionId: rentalTansactionId,
      );

      if (makePaymentIntentResponse != null) {
        //open stripe payment sheet
        final paymentIntent = makePaymentIntentResponse?.data?.paymentIntent;
        final ephemeralKey = makePaymentIntentResponse?.data?.ephemeralKey;
        final customer = makePaymentIntentResponse?.data?.customer;
        final publishableKey = makePaymentIntentResponse?.data?.publishableKey;

        // Stripe.publishableKey = publishableKey ?? "-";
        // await Stripe.instance.initPaymentSheet(
        //   paymentSheetParameters: SetupPaymentSheetParameters(
        //     customFlow: false,
        //     merchantDisplayName: 'CARRO',
        //     paymentIntentClientSecret: paymentIntent,
        //     customerEphemeralKeySecret: ephemeralKey,
        //     customerId: customer,
        //     style: ThemeMode.light,
        //   ),
        // );

        // EasyLoading.dismiss();

        // await Stripe.instance.presentPaymentSheet().then((value) {
        //   print(value);

        //   //Success
        //   //post API to save Data
        // }).onError((error, stackTrace) {
        //   EasyLoading.dismiss();
        //   if (error is StripeException) {
        //     EasyLoading.showError('${error.error.localizedMessage}');
        //   } else {
        //     EasyLoading.showError('Stripe Error: $error');
        //   }
        // });
      }
    }
  }
}
