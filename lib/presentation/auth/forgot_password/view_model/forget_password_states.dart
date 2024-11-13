import 'package:flutter/cupertino.dart';

@immutable
sealed class ForgotPasswordStates {}

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
class UpdateValidationState extends ForgotPasswordStates{}

