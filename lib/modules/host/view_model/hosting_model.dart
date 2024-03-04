import 'package:carro_flutter_app/core/provider/view_model/theme_provider.dart';
import 'package:carro_flutter_app/core/provider/view_state_model.dart';
import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/authentication/register/entity/normal_api_response.dart';
import 'package:carro_flutter_app/modules/bookings/entity/booking.dart';
import 'package:carro_flutter_app/modules/bookings/service/booking_service.dart';
import 'package:carro_flutter_app/modules/host/service/host_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HostingModel extends ViewStateModel {
  Bookings? _bookings;
  List<Booking> get getHostingList => _bookings?.data ?? [];

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  HostingModel() {
    //call api here initializ
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await init();
    });
  }

  init() async {
    setBusy();
    try {
      List response = await Future.wait([
        HostService.getHosting(),
      ]);

      if (response[0] != null) {
        _bookings = response[0];
      }

      print("My hostings length ${getHostingList.length}");
      refreshController.refreshCompleted();
      setIdle();
    } catch (e, s) {
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
        EasyLoading.showSuccess("Your bargaining price is saved.");
        await init();
        locator<CarroRouter>().navigateToAndRemoveUntil(CommonRoute.homePage);
        context.read<ThemeProvider>().setSelectedIndex(2);
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
}
