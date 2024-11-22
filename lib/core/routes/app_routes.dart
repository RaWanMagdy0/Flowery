import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repository/best_seller_repository_impl.dart';
import '../../presentation/auth/forgot_password/view/widgets/email_verification_widget/email_verification.dart';
import '../../presentation/auth/forgot_password/view/widgets/forgot_password_widget/forget_password_screen.dart';
import '../../presentation/auth/forgot_password/view_model/forget_passwoed_cubit.dart';
import '../../presentation/auth/sign_up/view/sign_up_page.dart';
import '../../presentation/auth/sign_up/view_model/sign_up_cubit.dart';
import '../../presentation/auth/view/login/login_screen.dart';
import '../../presentation/auth/view_model/login/login_cubit.dart';
import '../../presentation/best_seller/view/best_seller_screen.dart';
import '../../presentation/home_layout/product_details/view/product_details_screen.dart';
import '../../presentation/home_layout/screens/categories/categories_screen.dart';
import '../../presentation/home_layout/screens/main_page/main_page.dart';
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
        case PageRouteName.productDetails:
        return _handleMaterialPageRoute(widget: ProductDetails());
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

      case PageRouteName.bestSeller:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<BestSellerViewModel>(),
            child:  BestSellerScreen(),
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
      // _handleMaterialPageRoute(widget: const ForgetPassword());
      case PageRouteName.passwordVerification:
        createForgetPassword();
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: forgetPasswordCubit!,
            child: EmailVerification(),
          ),
        );
      // return _handleMaterialPageRoute(widget: EmailVerification());

      case PageRouteName.homeLayout:
        return _handleMaterialPageRoute(widget: MainPage());
      case PageRouteName.categoriesScreen:
        return _handleMaterialPageRoute(widget: CategoriesScreen());

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
