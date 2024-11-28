import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../repository/auth/auth_repository.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepository _repository;

  ResetPasswordUseCase(this._repository);

  Future<Result<void>> call({
    required String newPassword,
    required String email,
  }) {
    return _repository.resetPassword(
      email: email,
      newPassword: newPassword,
    );
  }
}