import 'package:flutter/cupertino.dart';

@immutable
sealed class ForgotPasswordStates {}

//ForgotPasswordStates
class ForgotPasswordInitialState extends ForgotPasswordStates {}
class ForgotPasswordErrorState extends ForgotPasswordStates {
  final String? errorMassage;
  ForgotPasswordErrorState({required this.errorMassage});
}
class ForgotPasswordLoadingState extends ForgotPasswordStates {
  String? loadingMessage;
  ForgotPasswordLoadingState({required this.loadingMessage});
}
class ForgotPasswordSuccessState extends ForgotPasswordStates {
  final String? success;
  ForgotPasswordSuccessState({required this.success});

}

//VerifyEmailCode
class VerifyEmailCodeErrorState extends ForgotPasswordStates {
  final String? errorMassage;
  VerifyEmailCodeErrorState({required this.errorMassage});
}
class VerifyEmailCodeLoadingState extends ForgotPasswordStates {
  String? loadingMessage;
  VerifyEmailCodeLoadingState({required this.loadingMessage});
}
class VerifyEmailCodeSuccessState extends ForgotPasswordStates {
  final String? success;
  VerifyEmailCodeSuccessState({required this.success});

}

class UpdateValidationState extends ForgotPasswordStates{}
