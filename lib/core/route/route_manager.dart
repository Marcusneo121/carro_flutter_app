import 'package:animations/animations.dart';
import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/modules/authentication/login/ui/login_page.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/register_address_page.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/register_confirmation_page.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/register_date_of_birth.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/register_name_page.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/register_page.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/register_password_page.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/register_phone_number.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/register_successful_page.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/register_username_email_page.dart';
import 'package:carro_flutter_app/modules/common/main_skeleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarroRouter {
  // static final GlobalKey<NavigatorState> navigatoryKey = GlobalKey<NavigatorState>();
  // static get navigationState => navigatoryKey.currentState;
  // static get appContext => navigationState.context;
  // static get overlayContext => navigationState.overlay.context;

  final GlobalKey<NavigatorState> navigatoryKey = GlobalKey<NavigatorState>();

  void pop() {
    return navigatoryKey.currentState!.pop();
  }

  Future<void> navigateTo(String routeName) {
    return navigatoryKey.currentState!.pushNamed(routeName);
  }

  Future<void> navigateToWithArgs(String routeName, String args) {
    return navigatoryKey.currentState!.pushNamed(routeName, arguments: args);
  }

  Future<void> navigateToAndRemoveUntil(String routeName) {
    return navigatoryKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  Future<void> navigateToAndRemoveUntilWithArgs(String routeName, String args) {
    return navigatoryKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (route) => false, arguments: args);
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CommonRoute.homePage:
        return CupertinoPageRoute(builder: (_) => const MainSkeleton());
      case CommonRoute.loginPage:
        return CupertinoPageRoute(builder: (_) => const LoginPage());
      case CommonRoute.registerPage:
        return CupertinoPageRoute(builder: (_) => const RegisterPage());
      case CommonRoute.registerUsernameEmailPage:
        return CupertinoPageRoute(
            builder: (_) => const RegisterUsernameEmailPage());
      case CommonRoute.registerNamePage:
        return getPageRouteFadeTransitionBuilder(
            settings, const RegisterNamePage());
      case CommonRoute.registerPasswordPage:
        return getPageRouteFadeTransitionBuilder(
            settings, const RegisterPasswordPage());
      case CommonRoute.registerAddressPage:
        return getPageRouteFadeTransitionBuilder(
            settings, const RegisterAddressPage());
      // return getPageRouteFadeThroughTransitionBuilder(settings, const RegisterAddressPage());
      // return CupertinoPageRoute(builder: (_) => const RegisterAddressPage());
      case CommonRoute.registerPhoneNumberPage:
        return getPageRouteFadeTransitionBuilder(
            settings, const RegisterPhoneNumberPage());
      case CommonRoute.registerDateOfBirthPage:
        return getPageRouteFadeTransitionBuilder(
            settings, const RegisterDateOfBirthPage());
      case CommonRoute.registerConfirmationPage:
        return getPageRouteFadeTransitionBuilder(
            settings, const RegisterConfirmationPage());
      case CommonRoute.registerSuccessfulPage:
        return getPageRouteFadeTransitionBuilder(
            settings, const RegisterSuccessfulPage());
      // case CommonRoute.textPage:
      //   return MaterialPageRoute(
      //       builder: (_) => MainSkeleton(selectedTabIndex: 1));
      // case CommonRoute.settingsPage:
      //   return MaterialPageRoute(
      //       builder: (_) => MainSkeleton(selectedTabIndex: 2));
      // case RouteNames.SCREEN2:
      //   var args = settings.arguments as String;
      //   return MaterialPageRoute(
      //       builder: (_) => Screen2(
      //             title: args,
      //           ));
      default:
        return CupertinoPageRoute(builder: (_) => const LoginPage());
    }
  }

  PageRouteBuilder getPageRouteFadeThroughTransitionBuilder(
      RouteSettings settings, Widget page) {
    return PageRouteBuilder(
      settings:
          settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder:
          (context, primaryAnimation, secondaryAnimation, child) =>
              FadeThroughTransition(
        animation: primaryAnimation,
        secondaryAnimation: secondaryAnimation,
        child: child,
      ),
    );
  }

  PageRouteBuilder getPageRouteFadeTransitionBuilder(
      RouteSettings settings, Widget page) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionDuration: const Duration(milliseconds: 150),
      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
    );
  }

  Route scaleIn(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, page) {
        var begin = 0.0;
        var end = 1.0;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return ScaleTransition(
          scale: animation.drive(tween),
          child: page,
        );
      },
    );
  }
}
