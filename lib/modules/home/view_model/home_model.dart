import 'package:carro_flutter_app/core/provider/view_state_model.dart';
import 'package:carro_flutter_app/modules/home/entity/car.dart';
import 'package:carro_flutter_app/modules/home/service/home_service.dart';
import 'package:carro_flutter_app/modules/settings/entity/post.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ViewStateModel {
  List<Post> post = [];
  late List<Car> cars;

  HomeProvider() {
    //call api here initializ
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await init();
    });
  }

  init() async {
    setBusy();
    try {
      List response = await Future.wait([
        HomeService.getPosts(),
        HomeService.getCars(),
      ]);

      if (response[0] != null) {
        post = response[0];
      }

      if (response[1] != null) {
        cars = response[1];
      }

      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }
}
