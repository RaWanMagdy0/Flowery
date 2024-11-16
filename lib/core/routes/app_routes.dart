import 'package:flowery/core/routes/page_route_name.dart';

import 'package:flowery/presentation/auth/view/forget_password/forget_password_screen.dart';
import 'package:flowery/presentation/home_layout/screens/main_page/main_page.dart';

import 'package:flutter/material.dart';

import '../../presentation/auth/forgot_password/view/widgets/email_verification_widget/email_verification.dart';
import '../../presentation/auth/forgot_password/view/widgets/forgot_password_widget/forget_password_screen.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      /*******************
      case PageRouteName.splash10:
        return _handleMaterialPageRoute(widget: const SplashView());
*****************/
      case PageRouteName.forgetPassword:
        return _handleMaterialPageRoute(widget: const ForgetPassword());
      case PageRouteName.homeLayout:
        return _handleMaterialPageRoute(widget: MainPage());

        return _handleMaterialPageRoute(widget: ForgetPassword());
      case PageRouteName.passwordVerification:
        return _handleMaterialPageRoute(widget: EmailVerification());

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
