import 'package:carro_flutter_app/core/provider/view_state_model.dart';
import 'package:carro_flutter_app/modules/authentication/register/entity/register.dart';
import 'package:flutter/material.dart';

class RegisterProvider extends ViewStateModel {
  RegisterData registrationData = RegisterData();

  RegisterProvider() {
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
}
