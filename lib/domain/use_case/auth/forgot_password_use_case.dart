import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/domain/repository/auth/auth_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class ForgotPasswordUseCase {
  AuthRepository repository;
  ForgotPasswordUseCase({required this.repository});
  Future<Result<String?>> invoke({required String email}) {
    return repository.forgotPassword(email: email);
  }
}
