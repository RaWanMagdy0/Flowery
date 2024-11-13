import 'package:flowery/core/routes/page_route_name.dart';
import 'package:flowery/presentation/auth/view/forget_password/forget_password_screen.dart';
import 'package:flowery/presentation/home_layout/screens/main_page/main_page.dart';
import 'package:flutter/material.dart';

import '../../splash/splash_view.dart';

class AppRoutes{
  static Route<dynamic>onGenerateRoute(RouteSettings setting){
    switch(setting.name){
      case PageRouteName.splash:
        return _handleMaterialPageRoute(widget: const SplashView());

      case PageRouteName.forgetPassword:
        return _handleMaterialPageRoute(widget: const ForgetPassword());

      case PageRouteName.homeLayout:
        return _handleMaterialPageRoute(widget: MainPage());

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