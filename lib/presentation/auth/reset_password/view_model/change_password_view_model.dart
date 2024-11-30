import 'package:flowery/presentation/auth/reset_password/view_model/change_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';


import '../../../../core/api/api_result.dart';
import '../../../../domain/repository/auth/auth_repository.dart';
import '../../../../domain/use_case/auth/change_password_use_case.dart';

@injectable
class ChangePasswordViewModel extends Cubit<ChangePasswordState> {
  final AuthRepository _authRepository;

  ChangePasswordViewModel(this._authRepository) : super(ChangePasswordInitial());

  void changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (!_validatePassword(newPassword)) {
      emit(ChangePasswordError(
          'Password must contain at least 6 characters, one uppercase letter, and one number'));
      return;
    }

    if (newPassword != confirmPassword) {
      emit(ChangePasswordError('Passwords do not match'));
      return;
    }

    emit(ChangePasswordLoading());

    final result = await _authRepository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    switch (result) {
      case Success():
        emit(ChangePasswordSuccess());
      case Fail():
        emit(ChangePasswordError(result.exception?.toString() ?? 'Unknown error'));
    }
  }

  bool _validatePassword(String password) {
    final RegExp passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[0-9]).{6,}$');
    return passwordRegExp.hasMatch(password);
  }
}