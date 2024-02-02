import 'package:carro_flutter_app/core/provider/view_state_model.dart';
import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/modules/authentication/register/entity/register.dart';
import 'package:flutter/material.dart';

class RegisterProvider extends ViewStateModel {
  RegisterData registrationData = RegisterData();
  bool page1Progress = false;
  bool page2Progress = false;
  bool page3Progress = false;
  bool page4Progress = false;
  bool page5Progress = false;

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

  registerProgressUpdater(String routeName) {
    switch (routeName) {
      case CommonRoute.registerUsernameEmailPage:
        page1Progress = true;
        break;
      case CommonRoute.registerPasswordPage:
        page1Progress = true;
        break;
      case CommonRoute.registerBiographyPage:
        page1Progress = true;
        break;
      case CommonRoute.registerAddressPage:
        page1Progress = true;
        break;
      case CommonRoute.registerNamePage:
        page1Progress = true;
        break;
      case 'clear':
        page1Progress = false;
        page2Progress = false;
        page3Progress = false;
        page4Progress = false;
        page5Progress = false;
        break;
      default:
    }

    notifyListeners();
  }

  resetToPageProgressUpdater(String routeName) {
    switch (routeName) {
      case CommonRoute.registerUsernameEmailPage:
        page1Progress = false;
        page2Progress = false;
        page3Progress = false;
        page4Progress = false;
        page5Progress = false;
        break;
      case CommonRoute.registerPasswordPage:
        page1Progress = true;
        break;
      case CommonRoute.registerBiographyPage:
        page1Progress = true;
        break;
      case CommonRoute.registerAddressPage:
        page1Progress = true;
        break;
      case CommonRoute.registerNamePage:
        page1Progress = true;
        break;
      default:
    }

    notifyListeners();
  }
}
