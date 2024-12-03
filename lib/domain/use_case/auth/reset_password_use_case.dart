import 'package:flowery/data/models/auth/requests/reset_password_request_model.dart';
import 'package:flowery/domain/repository/auth/auth_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepository authRepository;

  ResetPasswordUseCase({required this.authRepository});

  Future<Result<String?>> invoke(
      {required String email, required String newPassword}) {
    var requestBody =
        ResetPasswordRequestBody(email: email, newPassword: newPassword);
    return authRepository.resetPassword(requestBody);
  }
}
