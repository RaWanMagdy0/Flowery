import 'package:flutter/material.dart';

import '../../presentation/auth/view/forget_password/forget_password_screen.dart';
import '../../splash/splash_screen.dart';
import 'page_route_name.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case PageRouteName.splash:
        return _handleMaterialPageRoute(widget: const SplashScreen());
      case PageRouteName.forgetPassword:
        return _handleMaterialPageRoute(widget: const ForgetPassword());

      default:
        return _handleMaterialPageRoute(widget: const Scaffold());
    }
  }

  static MaterialPageRoute<dynamic> _handleMaterialPageRoute(
      {required Widget widget}) {
    return MaterialPageRoute(
      builder: (context) => widget,
    );
  }
}
