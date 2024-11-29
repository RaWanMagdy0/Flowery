sealed class ForgotPasswordStates {}

//ForgotPasswordStates
class ForgotPasswordInitialState extends ForgotPasswordStates {}

class ForgotPasswordErrorState extends ForgotPasswordStates {
  final String? errorMassage;
  ForgotPasswordErrorState({required this.errorMassage});
}

class ForgotPasswordLoadingState extends ForgotPasswordStates {
  final String? loadingMessage;
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
  final String? loadingMessage;
  VerifyEmailCodeLoadingState({required this.loadingMessage});
}

class VerifyEmailCodeSuccessState extends ForgotPasswordStates {
  final String? success;
  VerifyEmailCodeSuccessState({required this.success});
}

//ResendCode
class ResendLoadingState extends ForgotPasswordStates {
  String? loadingMessage;
  ResendLoadingState({required this.loadingMessage});
}

class ResendSuccessState extends ForgotPasswordStates {
  final String? success;
  ResendSuccessState({required this.success});
}

class ResendErrorState extends ForgotPasswordStates {
  final String? errorMassage;
  ResendErrorState({required this.errorMassage});
}
//ResetPassword
class ResetPasswordLoadingState extends ForgotPasswordStates {
  String? loadingMessage;
  ResetPasswordLoadingState({required this.loadingMessage});
}

class ResetPasswordSuccessState extends ForgotPasswordStates {
  final String? success;
  ResetPasswordSuccessState({required this.success});
}

class ResetPasswordErrorState extends ForgotPasswordStates {
  final String? errorMassage;
  ResetPasswordErrorState({required this.errorMassage});
}

class UpdateValidationState extends ForgotPasswordStates {}
