import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/addresses/view/add_and_edit_user_address/add_and_edit_user_address_screen.dart';
import '../../presentation/addresses/view_model/addresses_view_model.dart';
import '../../presentation/about_app/view/about_app_screen.dart';
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
import '../../presentation/home_layout/screens/cart/view_model/cart_view_model.dart';
import '../../presentation/home_layout/screens/categories/view/categories_screen.dart';
import '../../presentation/home_layout/screens/categories/view_model/categories_view_model.dart';
import '../../presentation/home_layout/screens/main_page/main_page.dart';
import '../../presentation/home_layout/screens/occasions/occasions_screen.dart';
import '../../presentation/home_layout/screens/occasions/view_model/ocusin_cubit.dart';
import '../../presentation/home_layout/screens/profile/change_password/view/change_password_screen.dart';
import '../../presentation/home_layout/screens/profile/change_password/view_model/change_password_view_model.dart';
import '../../presentation/home_layout/screens/profile/profile/view/edit_profile_screen.dart';
import '../../presentation/home_layout/screens/profile/profile/view/profile_main_screen.dart';
import '../../presentation/home_layout/screens/profile/profile/view_model/profile_cubit.dart';
import '../../presentation/terms_and_conditions/view/terms_and_conditions_screen.dart';
import '../../presentation/order/view/checkout_order_screen.dart';
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

      case PageRouteName.changePassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<ChangePasswordViewModel>(),
            child: const ChangePasswordScreen(),
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
        return _handleMaterialPageRoute(
          widget: MainPage(),
        );

      case PageRouteName.productDetails:
        final String productId = setting.arguments as String;

        return MaterialPageRoute(
          builder: (context) => ProductDetails(productId),
          settings: setting,
        );

      case PageRouteName.bestSeller:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<BestSellerViewModel>(),
            child: BestSellerScreen(),
          ),
        );

      case PageRouteName.categories:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<CategoriesViewModel>()..loadFlowers(),
            child: CategoriesScreen(),
          ),
          settings: setting,
        );

      case PageRouteName.aboutApp:
        return _handleMaterialPageRoute(widget: const AboutAppScreen());

      case PageRouteName.termsConditions:
        return _handleMaterialPageRoute(widget: const TermsAndConditionsScreen());
      case PageRouteName.occasion:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<OccasionCubit>()..loadFlowers(),
            child: OccasionScreen(),
          ),
        );

      case PageRouteName.mainProfile:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<ProfileCubit>(),
                  child: ProfileMainScreen(),
                ));
      case PageRouteName.editProfile:
        return _handleMaterialPageRoute(widget: EditProfileScreen());

      case PageRouteName.checkout:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<OrderCubit>(),
            child: CheckoutOrderScreen(),
          ),
        );

      case PageRouteName.addAndEditUserAddress:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<AddressesCubit>(),
            child: AddAndEditUserAddressScreen(),
          ),
        );

      case PageRouteName.savedAddresses:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<SavedAddressesViewModel>(),
            child: SavedAddressScreen(),
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
