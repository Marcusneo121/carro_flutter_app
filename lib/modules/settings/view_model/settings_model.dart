import 'package:carro_flutter_app/core/provider/view_state_model.dart';
import 'package:carro_flutter_app/modules/settings/entity/post.dart';
import 'package:carro_flutter_app/modules/settings/service/settings_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SettingsProvider extends ViewStateModel {
  List<Post> post = [];

  SettingsProvider() {
    //call api here initializ
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await init();
    });
  }

  init() async {
    setBusy();
    try {
      List response = await Future.wait([
        SettingsService.getPosts(),
      ]);

      if (response[0] != null) {
        post = response[0];
      }

      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }
}
