import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/auth/forgot_password/view/widgets/email_verification_widget/email_verification.dart';
import '../../presentation/auth/forgot_password/view/widgets/forgot_password_widget/forget_password_screen.dart';
import '../../presentation/auth/forgot_password/view_model/forget_passwoed_cubit.dart';
import '../../presentation/auth/sign_up/view/sign_up_page.dart';
import '../../presentation/auth/sign_up/view_model/sign_up_cubit.dart';
import '../di/di.dart';
import 'page_route_name.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      /*******************
      case PageRouteName.splash10:
        return _handleMaterialPageRoute(widget: const SplashView());
*****************/
      case PageRouteName.signUp:
        // return _handleMaterialPageRoute(widget: SignUpPage());
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<SignUpCubit>(),
                  child: SignUpPage(),
                ));
      case PageRouteName.forgetPassword:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<ForgetPasswordCubit>(),
                  child: ForgetPassword(),
                ));
      // return _handleMaterialPageRoute(widget: ForgetPassword());
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
