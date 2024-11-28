import 'package:flowery/presentation/home_layout/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/auth/forgot_password/view/widgets/email_verification_widget/email_verification.dart';
import '../../presentation/auth/forgot_password/view/widgets/forgot_password_widget/forget_password_screen.dart';
import '../../presentation/auth/forgot_password/view_model/forget_passwoed_cubit.dart';
import '../../presentation/auth/login/view/login_screen.dart';
import '../../presentation/auth/login/view_model/login_cubit.dart';
import '../../presentation/auth/sign_up/view/sign_up_page.dart';
import '../../presentation/auth/sign_up/view_model/sign_up_cubit.dart';
import '../../presentation/best_seller/view/best_seller_screen.dart';
import '../../presentation/best_seller/view_model/best_seller_view_model.dart';
import '../../presentation/home_layout/product_details/view/product_details_screen.dart';
import '../../presentation/home_layout/screens/categories/view/categories_screen.dart';
import '../../presentation/home_layout/screens/categories/view_model/categories_view_model.dart';
import '../../presentation/home_layout/screens/main_page/main_page.dart';
import '../../presentation/home_layout/screens/occasions/occasions_screen.dart';
import '../../presentation/home_layout/screens/occasions/view_model/ocusin_cubit.dart';
import '../../splash/splash_screen.dart';
import '../di/di.dart';
import 'page_route_name.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    ForgetPasswordCubit? forgetPasswordCubit;

    createForgetPassword() {
      forgetPasswordCubit ??= getIt<ForgetPasswordCubit>();
    }

    switch (setting.name) {
      case PageRouteName.splash:
        return _handleMaterialPageRoute(widget: const SplashScreen());

      case PageRouteName.logIn:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<LoginViewModel>(),
            child: LogInScreen(),
          ),
        );

      case PageRouteName.signUp:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: SignUpPage(),
          ),
        );

      case PageRouteName.forgetPassword:
        createForgetPassword();

        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => forgetPasswordCubit!,
            child: ForgetPassword(),
          ),
        );

      case PageRouteName.passwordVerification:
        createForgetPassword();
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: forgetPasswordCubit!,
            child: EmailVerification(),
          ),
        );

      case PageRouteName.homeLayout:
        return _handleMaterialPageRoute(widget: MainPage());
 case PageRouteName.profile:
        return _handleMaterialPageRoute(widget: ProfileScreen());

      case PageRouteName.productDetails:
        return MaterialPageRoute(
          builder: (context) => ProductDetails(),
          settings: setting,
        );

      case PageRouteName.categories:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<CategoriesViewModel>()..loadFlowers(),
            child: CategoriesScreen(),
          ),
          settings: setting,
        );

      case PageRouteName.bestSeller:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<BestSellerViewModel>(),
            child: BestSellerScreen(),
          ),
        );

      case PageRouteName.occasion:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<OccasionCubit>()..loadFlowers(),
            child: OccasionScreen(),
          ),
        );

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
