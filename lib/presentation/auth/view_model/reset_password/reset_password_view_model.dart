import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/domain/use_case/reset_password_usecase.dart';
import 'package:flowery/presentation/auth/view_model/reset_password/reset_password_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/base/base_view_model.dart';
import '../../../../domain/entities/auth/User.dart';

@injectable
class ResetPasswordViewModel extends BaseViewModel<ResetPasswordStates> {
  ResetPasswordUseCase resetPasswordUseCase;

  ResetPasswordViewModel(this.resetPasswordUseCase)
      : super(ResetPasswordInitialState());

  Future<void> resetPassword(String confirmPassword, String newPassword) async {
    emit(ResetPasswordLoadingState(loadingMessage: "loading..."));
    final result = await resetPasswordUseCase.invoke(
        confirmPassword: confirmPassword, newPassword: newPassword);
    switch (result) {
      case Success<User?>():
        emit(ResetPasswordSuccessState());
      case Fail<User?>():
        emit(ResetPasswordErrorState(
            errorMassage: getErrorMassageFromException(result.exception)));
    }
  }
}
