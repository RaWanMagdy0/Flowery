import 'package:flowery/presentation/auth/reset_password/view_model/reset_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';


import '../../../../core/api/api_result.dart';
import '../../../../domain/use_case/auth/reset_password_use_case.dart';

@injectable
class ResetPasswordViewModel extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase _resetPasswordUseCase;

  ResetPasswordViewModel(this._resetPasswordUseCase) : super(ResetPasswordInitial());

  void resetPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (!_validatePassword(newPassword)) {
      emit(ResetPasswordError(
          'Password must contain at least 6 characters, one uppercase letter, and one number'));
      return;
    }

    if (newPassword != confirmPassword) {
      emit(ResetPasswordError('Passwords do not match'));
      return;
    }

    emit(ResetPasswordLoading());

    final result = await _resetPasswordUseCase(
      email: email,
      newPassword: newPassword,
    );

    switch (result) {
      case Success():
        emit(ResetPasswordSuccess());
      case Fail():
        emit(ResetPasswordError(result.exception?.toString() ?? 'Unknown error'));
    }
  }

  bool _validatePassword(String password) {
    final RegExp passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[0-9]).{6,}$');
    return passwordRegExp.hasMatch(password);
  }
}