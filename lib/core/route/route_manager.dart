import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/modules/authentication/login/ui/login_page.dart';
import 'package:carro_flutter_app/modules/common/main_skeleton.dart';
import 'package:flutter/material.dart';

class CarroRouter {
  // static final GlobalKey<NavigatorState> navigatoryKey = GlobalKey<NavigatorState>();
  // static get navigationState => navigatoryKey.currentState;
  // static get appContext => navigationState.context;
  // static get overlayContext => navigationState.overlay.context;

  final GlobalKey<NavigatorState> navigatoryKey = GlobalKey<NavigatorState>();

  void pop(String routeName) {
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
        return MaterialPageRoute(builder: (_) => const MainSkeleton());
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
      case CommonRoute.loginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}
