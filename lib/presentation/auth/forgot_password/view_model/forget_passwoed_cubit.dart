import 'dart:async';

import 'package:flowery/domain/use_case/auth/reset_password_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../core/base/base_view_model.dart';
import '../../../../core/di/di.dart';
import '../../../../core/utils/functions/providers/app_provider.dart';
import '../../../../domain/use_case/auth/forgot_password_use_case.dart';
import '../../../../domain/use_case/auth/verify_reset_code_use_case.dart';
import 'forget_password_states.dart';

@injectable
class ForgetPasswordCubit extends BaseViewModel<ForgotPasswordStates> {
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final VerifyResetCodeUseCase verifyResetCodeUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  late Timer timer;
  int time = 60;
  String? userEmail;
  ValueNotifier<String?> resendButtonText = ValueNotifier<String?>(" Resend");
  ValueNotifier<bool> isResendButtonEnabled = ValueNotifier<bool>(true);

  final appProvider = getIt.get<AppProvider>();

  ForgetPasswordCubit(
    this.forgotPasswordUseCase,
    this.verifyResetCodeUseCase,
      this.resetPasswordUseCase
  ) : super(ForgotPasswordInitialState());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final PageController pageController = PageController();
  var emailController = TextEditingController();
  var emailFormKey = GlobalKey<FormState>();

  void startResendTimer() {
    time = 60;
    isResendButtonEnabled.value = false;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time > 1) {
        time--;
        resendButtonText.value = formatTime(time);
      } else {
        timer.cancel();
        resendButtonText.value = " Resend";
        isResendButtonEnabled.value = true;
      }
    });
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$remainingSeconds";
  }

  void disposeTimer() {
    timer.cancel();
  }

  Future<void> forgotPassword() async {
    emit(ForgotPasswordLoadingState(loadingMessage: "loading..."));
    userEmail = emailController.text;
    appProvider.email = userEmail!;
    var result = await forgotPasswordUseCase.invoke(email: userEmail!);
    switch (result) {
      case Success<String?>():
        emit(ForgotPasswordSuccessState(success: result.data));
        break;
      case Fail<String?>():
        emit(ForgotPasswordErrorState(
            errorMassage: getErrorMassageFromException(result.exception)));
    }
  }

  Future<void> resendResetCode() async {
    emit(ResendLoadingState(loadingMessage: "loading..."));
    var result = await forgotPasswordUseCase.invoke(email: appProvider.email);
    switch (result) {
      case Success<String?>():
        emit(ResendSuccessState(success: result.data));
      case Fail<String?>():
        emit(ResendErrorState(
            errorMassage: getErrorMassageFromException(result.exception)));
    }
  }

  Future<void> verifyResetCode({required String resetCode}) async {
    emit(VerifyEmailCodeLoadingState(loadingMessage: 'Loading...'));
    var result = await verifyResetCodeUseCase.invoke(resetCode: resetCode);
    switch (result) {
      case Success<String?>():
        emit(VerifyEmailCodeSuccessState(success: result.data));
      case Fail<String?>():
        emit(VerifyEmailCodeErrorState(
            errorMassage: getErrorMassageFromException(result.exception)));
    }
  }
  
  Future<void> resetPassword(String newPassword) async {
    emit(ResetPasswordLoadingState(loadingMessage: "loading..."));
    final result = await resetPasswordUseCase.invoke(email: appProvider.email, newPassword: newPassword);
    switch (result) {
      case Success<String?>():
        emit(ResetPasswordSuccessState(success: result.data));
      case Fail<String?>():
        emit(ResetPasswordErrorState(
            errorMassage: getErrorMassageFromException(result.exception)));
    }
  }
  void submitForgotPassword() {
    if (formKey.currentState!.validate()) {
      forgotPassword();
    }
  }

  bool isValid = true;
  void updateValidationState() {
    if (formKey.currentState!.validate()) {
      isValid = true;
    } else {
      isValid = false;
    }
    emit(UpdateValidationState());
  }
}
