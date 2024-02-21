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
  bool page6Progress = false;

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

  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  registerProgressUpdater(String routeName) {
    switch (routeName) {
      case CommonRoute.registerUsernameEmailPage:
        page1Progress = true;
        break;
      case CommonRoute.registerNamePage:
        page2Progress = true;
        break;
      case CommonRoute.registerPasswordPage:
        page3Progress = true;
        break;
      case CommonRoute.registerPhoneNumberPage:
        page4Progress = true;
        break;
      case CommonRoute.registerDateOfBirthPage:
        page5Progress = true;
        break;
      case CommonRoute.registerAddressPage:
        page6Progress = true;
        break;
      case CommonRoute.registerConfirmationPage:
        page6Progress = true;
        break;

      case 'clear':
        page1Progress = false;
        page2Progress = false;
        page3Progress = false;
        page4Progress = false;
        page5Progress = false;
        page6Progress = false;
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
        page5Progress = false;
        page6Progress = false;
        break;
      case CommonRoute.registerNamePage:
        page1Progress = true;
        page2Progress = false;
        page3Progress = false;
        page4Progress = false;
        page6Progress = false;
        break;
      case CommonRoute.registerPasswordPage:
        page1Progress = true;
        page2Progress = true;
        page3Progress = false;
        page4Progress = false;
        page5Progress = false;
        page6Progress = false;
        break;
      case CommonRoute.registerPhoneNumberPage:
        page1Progress = true;
        page2Progress = true;
        page3Progress = true;
        page4Progress = false;
        page5Progress = false;
        page6Progress = false;
        break;
      case CommonRoute.registerDateOfBirthPage:
        page1Progress = true;
        page2Progress = true;
        page3Progress = true;
        page4Progress = true;
        page5Progress = false;
        page6Progress = false;
        break;
      case CommonRoute.registerAddressPage:
        page1Progress = true;
        page2Progress = true;
        page3Progress = true;
        page4Progress = true;
        page5Progress = true;
        page6Progress = false;
        break;
      case CommonRoute.registerConfirmationPage:
        page1Progress = true;
        page2Progress = true;
        page3Progress = true;
        page4Progress = true;
        page5Progress = true;
        page6Progress = true;
        break;

      default:
    }

    notifyListeners();
  }

  setRegisterDataClass({required String page, required RegisterData data}) {
    switch (page) {
      case CommonRoute.registerUsernameEmailPage:
        registrationData.username = data.username;
        registrationData.email = data.email;
        break;
      case CommonRoute.registerNamePage:
        registrationData.firstName = data.firstName;
        registrationData.lastName = data.lastName;
        break;
      case CommonRoute.registerPasswordPage:
        registrationData.password = data.password;
        break;
      case CommonRoute.registerPhoneNumberPage:
        registrationData.phoneNumber = data.phoneNumber;
        break;
      case CommonRoute.registerDateOfBirthPage:
        registrationData.dateOfBirth = data.dateOfBirth;
        registrationData.age = calculateAge(data.dateOfBirth ?? DateTime.now());
        break;
      case CommonRoute.registerAddressPage:
        registrationData.address1 = data.address1;
        registrationData.address2 = data.address2 == "" ? null : data.address2;
        registrationData.address3 = data.address3 == "" ? null : data.address3;
        registrationData.poscode = data.poscode;
        registrationData.city = data.city;
        registrationData.state = data.state;
        break;
      default:
    }

    notifyListeners();
  }

  displayRegisterData() {
    print(registrationData.toJson());
  }
}
