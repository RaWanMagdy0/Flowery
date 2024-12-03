import 'package:injectable/injectable.dart';

import '../../../../../../core/api/api_result.dart';
import '../../../../../../core/base/base_view_model.dart';
import '../../../../../../domain/repository/auth/auth_repository.dart';
import 'change_password_state.dart';

@injectable
class ChangePasswordViewModel extends BaseViewModel<ChangePasswordState> {
  final AuthRepository _authRepository;

  ChangePasswordViewModel(this._authRepository)
      : super(ChangePasswordInitial());

  void changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ChangePasswordLoading());
    final result = await _authRepository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    switch (result) {
      case Success<String?>():
        emit(ChangePasswordSuccess());
      case Fail<String?>():
        emit(ChangePasswordError(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }
}
