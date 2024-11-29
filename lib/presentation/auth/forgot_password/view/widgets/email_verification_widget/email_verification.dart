import 'package:flowery/presentation/auth/forgot_password/view/widgets/email_verification_widget/widget/email_verification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../view_model/forget_passwoed_cubit.dart';
import '../../../view_model/forget_password_states.dart';
import '../reset_password_widget/reset_password_widget.dart';

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
  List<Widget> page = [];
  @override
  void initState() {
    super.initState();
    viewModel = context.read<ForgetPasswordCubit>();
    page = [
      EmailVerificationWidget(
        viewModel: viewModel,
      ),
      ResetPasswordViewBody(),
    ];
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
              children: page)),
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
