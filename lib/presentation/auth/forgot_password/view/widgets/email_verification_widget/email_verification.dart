import 'package:flowery/core/di/di.dart';
import 'package:flowery/core/styles/fonts/app_fonts.dart';
import 'package:flowery/core/utils/const/app_string.dart';
import 'package:flowery/presentation/auth/forgot_password/view/widgets/email_verification_widget/widget/pin_code_file.dart';
import 'package:flowery/presentation/auth/forgot_password/view_model/forget_passwoed_cubit.dart';
import 'package:flowery/presentation/auth/forgot_password/view_model/forget_password_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../reset_password_widget/reset_password_widget.dart';

class EmailVerification extends StatefulWidget {
  static const String routeName = "PasswordVerification";

  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  var viewModel = getIt.get<ForgetPasswordCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgotPasswordStates>(
      bloc: viewModel,
      listener: (context, state) => _handelStateChange(state),
      child: Scaffold(
          body: PageView(
        controller: viewModel.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.arrow_back_ios_outlined),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      AppStrings.passwordAppBarTitle,
                      style: AppFonts.font20BlackWeight400,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(AppStrings.emailVerificationScreenTitle,
                    style: AppFonts.font18BlackWeight500),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  AppStrings.emailVerificationScreenDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                PinCodeFile(
                  onCodeCompleted: (resetCode) {
                    viewModel.verifyResetCode(resetCode: resetCode);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.didnotReceiveCode,
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w400),
                    ),
                    Text(AppStrings.resendText,
                        style: AppFonts.font15PinkWeight500),
                  ],
                ),
              ],
            ),
          ),
          ResetPasswordWidget(),
        ],
      )),
    );
  }

  dynamic _handelStateChange(ForgotPasswordStates state) {
    if (state is VerifyEmailCodeSuccessState) {
      Navigator.pop(context);
      viewModel.pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
      );
    } else if (state is VerifyEmailCodeLoadingState) {
      AppDialogs.showLoading(context: context);
    } else if (state is VerifyEmailCodeErrorState) {
      Navigator.pop(context);
      AppDialogs.showErrorDialog(
        context: context,
        errorMassage: state.errorMassage ?? "An unknown error occurred",
      );
    }
  }
}
