import 'package:carro_flutter_app/core/constants/strings.dart';
import 'package:carro_flutter_app/core/models/lougout_response.dart';
import 'package:carro_flutter_app/core/models/user_session.dart';
import 'package:carro_flutter_app/core/provider/view_model/theme_provider.dart';
import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/utils/shared_prefs.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/authentication/register/entity/register.dart';
import 'package:carro_flutter_app/modules/authentication/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final BuildContext context;
  SharedPrefs sharef = SharedPrefs();

  AuthController({required this.context}) {
    //call api here initialize
  }

  login(String username, String password) async {
    EasyLoading.show(dismissOnTap: false);
    UserSession? userLoginData = await AuthService.login(username, password);
    if (userLoginData != null) {
      sharef.setSessionData = userLoginData;
      print(userLoginData.token?.token);
      locator<CarroRouter>().navigateToAndRemoveUntil(CommonRoute.homePage);
      EasyLoading.dismiss();
    } else {}

    // else {
    //   EasyLoading.showError(
    //     'Login Error, please try again.',
    //     dismissOnTap: false,
    //     duration: const Duration(seconds: 2),
    //   );
    // }
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(
    //       builder: (context) => const MainSkeleton(),
    //     ),
    //     (Route<dynamic> route) => false);
  }

  register({required RegisterData data}) {}

  logout() async {
    EasyLoading.show(dismissOnTap: false);
    LogoutResponse? userLogoutData = await AuthService.logout();
    print(sharef.userSessionData.token?.token.toString());
    if (userLogoutData != null) {
      sharef.removeSessionData();
      context.read<ThemeProvider>().setSelectedIndex(0);
      locator<CarroRouter>().navigateToAndRemoveUntil(CommonRoute.loginPage);
      EasyLoading.dismiss();
    }
  }

  checkUserSession() {
    if (sharef.getStringUserSessionData != null) {
      if (sharef.userSessionData.token?.expiresAt != null) {
        DateTime dt1 = DateTime.now();
        DateTime dt2 =
            DateTime.parse(sharef.userSessionData.token?.expiresAt ?? "");

        if (dt1.compareTo(dt2) > 0) {
          //DT1 is after DT2
          EasyLoading.showError('Session Expired. Please login again.');
          sharef.removeSessionData();
          locator<CarroRouter>()
              .navigateToAndRemoveUntil(CommonRoute.loginPage);
        } else {
          locator<CarroRouter>().navigateToAndRemoveUntil(CommonRoute.homePage);
        }
      }
    } else {
      locator<CarroRouter>().navigateToAndRemoveUntil(CommonRoute.loginPage);
    }
  }
}
