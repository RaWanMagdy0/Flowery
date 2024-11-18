import 'package:flutter/cupertino.dart';

import '../../../../domain/entities/auth/User.dart';

@immutable
sealed class ResetPasswordStates {}

class ResetPasswordInitialState extends ResetPasswordStates {}

class ResetPasswordErrorState extends ResetPasswordStates {
  final String? errorMassage;

  ResetPasswordErrorState({required this.errorMassage});
}

class ResetPasswordLoadingState extends ResetPasswordStates {
  String? loadingMessage;

  ResetPasswordLoadingState({required this.loadingMessage});
}

class ResetPasswordSuccessState extends ResetPasswordStates {}

class UpdateValidationState extends ResetPasswordStates {}
