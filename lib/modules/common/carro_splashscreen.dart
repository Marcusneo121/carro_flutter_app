import 'dart:convert';
import 'package:carro_flutter_app/core/constants/strings.dart';
import 'package:carro_flutter_app/core/controller/auth_controller.dart';
import 'package:carro_flutter_app/core/models/user_session.dart';
import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/utils/shared_prefs.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/authentication/login/ui/login_page.dart';
import 'package:carro_flutter_app/modules/common/main_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarroSplashscreen extends StatefulWidget {
  const CarroSplashscreen({super.key});

  @override
  State<CarroSplashscreen> createState() => _CarroSplashscreenState();
}

class _CarroSplashscreenState extends State<CarroSplashscreen> {
  // Map<String, dynamic> sessionDataTesting = {
  //   "data": {
  //     "user": {
  //       "id": 1,
  //       "role_id": 0,
  //       "username": "Tembikai121",
  //       "email": "marcus121neo@gmail.com",
  //       "remember_me_token": null,
  //       "created_at": "2024-01-24T15:50:25.971+08:00",
  //       "updated_at": "2024-01-24T15:50:25.971+08:00"
  //     },
  //     "profile": {
  //       "id": 1,
  //       "user_id": 1,
  //       "first_name": "Marcus",
  //       "last_name": "Yin Neo",
  //       "address1": "Taman 1",
  //       "address2": "Taman 2",
  //       "address3": "Taman 3",
  //       "age": "23",
  //       "phone_number": "018-9134373",
  //       "date_of_birth": "2000-12-01T11:18:53.411Z",
  //       "profile_image": null,
  //       "created_at": "2024-01-24T15:50:25.977+08:00",
  //       "updated_at": "2024-01-24T15:50:25.977+08:00"
  //     }
  //   },
  //   "token": {
  //     "type": "bearer",
  //     "token":
  //         "Mw.Y1mfaGfC8oNXKHSXdlS8fsaKDergddyJ9frtGZRMxcUU8La_YnuyOzRuuB13",
  //     "expires_at": "2024-02-05T22:51:22.217+08:00"
  //   },
  //   "message": "Login Succesfully"
  // };

  // checkSession() async {
  //   SharedPrefs().setSessionData = UserSession.fromJson(sessionData);
  //   // final SharedPreferences preferences = await SharedPreferences.getInstance();
  //   // if (preferences.getString('user_session') != null) {
  //   //   //go to home screen
  //   // } else {
  //   //   //go to login page
  //     Future.delayed(const Duration(seconds: 3), () {
  //       Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(
  //             builder: (context) => const MainSkeleton(),
  //           ),
  //           (Route<dynamic> route) => false);
  //     });
  //   //   if (!mounted) return;
  //   // }
  //   // preferences.setString('user_session', jsonEncode(sessionData));
  //   // Future.delayed(const Duration(seconds: 3), () {
  //   //   UserSession data = UserSession.fromJson(
  //   //       jsonDecode(preferences.getString('user_session') ?? ""));
  //   //   print(preferences.getString('user_session'));
  //   //   print(data.token?.token);
  //   //   preferences.remove('user_session');
  //   //   print(preferences.getString('user_session'));
  //   // });
  // }

  // addPref() {
  //   SharedPrefs().setSessionData = UserSession.fromJson(sessionDataTesting);
  // }

  checkSession() {
    if (SharedPrefs().sharedPrefInstance.getString(sessionData) != null) {
      locator<CarroRouter>().navigateToAndRemoveUntil(CommonRoute.homePage);
    } else {
      locator<CarroRouter>().navigateToAndRemoveUntil(CommonRoute.loginPage);
    }
  }

  @override
  void initState() {
    super.initState();
    //addPref();
    Future.delayed(const Duration(seconds: 3), () {
      checkSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CarroColors.getColor(context, CarroColors.scaffoldBackgroundColor),
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: 400,
            height: 100,
            child: Theme.of(context).colorScheme.brightness == Brightness.light
                ? Image.asset('images/carros_white.png')
                : Image.asset('images/carros.png'),
          ),
        ),
      ),
    );
  }
}
