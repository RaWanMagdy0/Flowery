import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/domain/use_case/auth/forgot_password_use_case.dart';
import 'package:flowery/presentation/auth/forgot_password/view_model/forget_password_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base/base_view_model.dart';

@injectable
class ForgetPasswordCubit extends BaseViewModel<ForgotPasswordStates> {
  final ForgotPasswordUseCase forgotPasswordUseCase;
  ForgetPasswordCubit(
    this.forgotPasswordUseCase,
  ) : super(ForgotPasswordInitialState());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final PageController pageController = PageController();
  var emailController = TextEditingController();
  var emailFormKey = GlobalKey<FormState>();


  Future<void> forgotPassword()async{
    emit(ForgotPasswordLoadingState(loadingMessage: "loading..."));
    var result=await forgotPasswordUseCase.invoke(email: emailController.text);
    switch(result){
      case Success<String?>():emit(ForgotPasswordSuccessState(success: result.data));
      case Fail<String?>():
        emit(ForgotPasswordErrorState(errorMassage: getErrorMassageFromException(result.exception)));
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
