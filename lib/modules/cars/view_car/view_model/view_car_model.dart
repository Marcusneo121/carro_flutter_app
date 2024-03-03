import 'package:carro_flutter_app/core/provider/view_state_model.dart';
import 'package:carro_flutter_app/modules/cars/service/car_service.dart';
import 'package:carro_flutter_app/modules/cars/view_car/entity/host.dart';
import 'package:carro_flutter_app/modules/home/entity/car.dart';
import 'package:flutter/material.dart';

class ViewCarModel extends ViewStateModel {
  late Car _carData;
  Host? _ownerData;
  List<String> _imageList = [];

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
}
