import 'package:carro_flutter_app/core/provider/view_state_model.dart';
import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/authentication/register/entity/normal_api_response.dart';
import 'package:carro_flutter_app/modules/cars/service/car_service.dart';
import 'package:carro_flutter_app/modules/cars/view_car/entity/host.dart';
import 'package:carro_flutter_app/modules/home/entity/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ViewCarModel extends ViewStateModel {
  late Car _carData;
  Host? _ownerData;
  List<String> _imageList = [];

  Car get getCarData => _carData;
  Host? get getOwnerData => _ownerData;
  List<String> get getImageList => _imageList;

  ViewCarModel({required Car car}) {
    //call api here initializ
    _carData = car;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await init();
    });
  }

  init() async {
    setBusy();
    try {
      _imageList = [
        _carData.carMainPic ?? "-",
        _carData.carImageOne ?? "-",
        _carData.carImageTwo ?? "-",
        _carData.carImageThree ?? "-",
        _carData.carImageFour ?? "-",
      ];

      List response = await Future.wait([
        CarService.getOwnerDetails(_carData.userId ?? -1),
      ]);

      if (response[0] != null) {
        _ownerData = response[0];
      }

      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  bookCar(
      {required int? carID,
      required String bargainAmount,
      required DateTime rentFrom,
      required DateTime rentTo}) async {
    setBusy();
    EasyLoading.show(dismissOnTap: false);
    if (carID != null) {
      NormalApiResponse? carBookingResponse = await CarService.bookCar(
        carID, //should be available
        bargainAmount,
        rentFrom,
        rentTo,
      );
      if (carBookingResponse != null) {
        EasyLoading.dismiss();
        locator<CarroRouter>()
            .navigateToAndRemoveUntil(CarRoute.bookSuccessfulPage);
      }
    } else {
      EasyLoading.showError(
        "Something went wrong, please try again.",
        duration: const Duration(
          seconds: 3,
        ),
      );
    }
    setIdle();
  }
}
