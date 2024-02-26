import 'dart:io';

import 'package:carro_flutter_app/core/provider/view_state_model.dart';
import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/authentication/register/entity/normal_api_response.dart';
import 'package:carro_flutter_app/modules/cars/add_car/entity/add_car.dart';
import 'package:carro_flutter_app/modules/cars/service/car_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddCarProvider extends ViewStateModel {
  AddCar carToAdd = AddCar();

  AddCarProvider() {
    //call api here initializ
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await init();
    });
  }

  init() async {
    setBusy();
    try {
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  clearCar() {
    carToAdd = AddCar();
    print(carToAdd.toJson().toString());
  }

  addCarPage1Updater({
    required String carBrandAndName,
    required String carColor,
    required bool isElectricCar,
    required String engineCapacity,
    required String yearMade,
    required String seatNumber,
    required String carPlate,
  }) {
    carToAdd.carName = carBrandAndName;
    carToAdd.color = carColor;
    carToAdd.isElectric = isElectricCar;
    carToAdd.engineCapacity = engineCapacity;
    carToAdd.yearMade = yearMade;
    carToAdd.seat = seatNumber;
    carToAdd.carPlate = carPlate;

    print(carToAdd.toJson().toString());
    notifyListeners();
  }

  addCarPage2Updater({
    required String price,
    required String location,
  }) {
    carToAdd.price = price;
    carToAdd.location = location;

    print(carToAdd.toJson().toString());
    notifyListeners();
  }

  addCarPage3Updater({
    required DateTime availableFrom,
    required DateTime availableTo,
  }) {
    carToAdd.availableFromDate = availableFrom;
    carToAdd.availableToDate = availableTo;

    print(carToAdd.toJson().toString());
    notifyListeners();
  }

  addCarPage4Updater(
      {required XFile imageMainExterior,
      required XFile image1Exterior,
      required XFile image2Exterior,
      required XFile image3Interior,
      required XFile image4Interior}) {
    carToAdd.carMainPic = File(imageMainExterior.path);
    carToAdd.carImageOne = File(image1Exterior.path);
    carToAdd.carImageTwo = File(image2Exterior.path);
    carToAdd.carImageThree = File(image3Interior.path);
    carToAdd.carImageFour = File(image4Interior.path);

    print(carToAdd.toJson().toString());
    print(carToAdd.availableFromDate?.toIso8601String());
    print(DateFormat('yyyy-MM-ddTHH:mm:ss.SSS')
        .format(carToAdd.availableFromDate ?? DateTime.now()));
    notifyListeners();
  }

  addCar() async {
    try {
      EasyLoading.show(status: "Hosting your car...", dismissOnTap: false);
      NormalApiResponse? addCarResponse = await CarService.addCar(carToAdd);

      if (addCarResponse != null) {
        EasyLoading.dismiss();
        locator<CarroRouter>()
            .navigateToAndRemoveUntil(CarRoute.addCarSuccessfulPage);
      }
    } catch (e) {
      print("wrong 2");
      EasyLoading.showError("Something went wrong, please try again.");
    }
  }
}
