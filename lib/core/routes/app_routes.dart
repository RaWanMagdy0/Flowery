import 'package:flowery/core/routes/page_route_name.dart';
import 'package:flutter/material.dart';

import '../../presentation/auth/forgot_password/view/forget_password_screen.dart';
import '../../presentation/auth/forgot_password/view/password_verification.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      /*******************
      case PageRouteName.splash10:
        return _handleMaterialPageRoute(widget: const SplashView());
*****************/
      case PageRouteName.forgetPassword:
        return _handleMaterialPageRoute(widget: ForgetPassword());
      case PageRouteName.passwordVerification:
        return _handleMaterialPageRoute(widget: PasswordVerification());

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
