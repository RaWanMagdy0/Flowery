import 'package:flowery/core/routes/page_route_name.dart';
import 'package:flowery/presentation/auth/view/forget_password/forget_password_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoutes{
  static Route<dynamic>onGenerateRoute(RouteSettings setting){
    switch(setting.name){
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