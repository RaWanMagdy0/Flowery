import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/di/di.dart';
import '../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../core/utils/const/app_string.dart';
import '../../../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../view_model/forget_passwoed_cubit.dart';
import '../../../view_model/forget_password_states.dart';
import '../reset_password_widget/reset_password_widget.dart';
import 'widget/pin_code_file.dart';

class EmailVerification extends StatefulWidget {
  static const String routeName = "PasswordVerification";

  const EmailVerification({
    super.key,
  });
  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  var viewModel = getIt.get<ForgetPasswordCubit>();

  @override
  void initState() {
    super.initState();
    viewModel = context.read<ForgetPasswordCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgotPasswordStates>(
      bloc: viewModel,
      listener: (context, state) => _handleStateChange(state),
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
                    ValueListenableBuilder<bool>(
                      valueListenable: viewModel.isResendButtonEnabled,
                      builder: (context, isEnabled, child) {
                        return InkWell(
                          onTap: isEnabled
                              ? () {
                                  viewModel.resendResetCode();
                                }
                              : null,
                          child: ValueListenableBuilder<String?>(
                            valueListenable: viewModel.resendButtonText,
                            builder: (context, value, child) {
                              return Text(
                                value ?? " Resend",
                                style: isEnabled
                                    ? AppFonts.font16PinkWeight400
                                    : AppFonts.font16PinkWeight400,
                              );
                            },
                          ),
                        );
                      },
                    ),
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

  dynamic _handleStateChange(ForgotPasswordStates state) {
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
    } else if (state is ResendLoadingState) {
      AppDialogs.showLoading(context: context);
    } else if (state is ResendSuccessState) {
      Navigator.pop(context);
      AppDialogs.showSuccessDialog(
        context: context,
        message: "Resend OTP to your email.\n Please check your Email",
      );
      viewModel.startResendTimer();
    } else if (state is ResendErrorState) {
      Navigator.pop(context);
      AppDialogs.showErrorDialog(
        context: context,
        errorMassage: state.errorMassage ?? "An unknown error occurred",
      );
    }
  }
}
