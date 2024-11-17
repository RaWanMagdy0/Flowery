import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../core/base/base_view_model.dart';
import '../../../../domain/use_case/auth/forgot_password_use_case.dart';
import '../../../../domain/use_case/auth/verify_reset_code_use_case.dart';
import 'forget_password_states.dart';

@injectable
class ForgetPasswordCubit extends BaseViewModel<ForgotPasswordStates> {
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final VerifyResetCodeUseCase verifyResetCodeUseCase;
  ForgetPasswordCubit(
    this.forgotPasswordUseCase,
    this.verifyResetCodeUseCase,
  ) : super(ForgotPasswordInitialState());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final PageController pageController = PageController();
  var emailController = TextEditingController();
  var emailFormKey = GlobalKey<FormState>();

  Future<void> forgotPassword() async {
    emit(ForgotPasswordLoadingState(loadingMessage: "loading..."));
    var result =
        await forgotPasswordUseCase.invoke(email: emailController.text);
    switch (result) {
      case Success<String?>():
        emit(ForgotPasswordSuccessState(success: result.data));
      case Fail<String?>():
        emit(ForgotPasswordErrorState(
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
