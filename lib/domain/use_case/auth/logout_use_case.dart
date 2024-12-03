import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/domain/repository/auth/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  Future<Result<String?>> invoke() {
    return authRepository.logout();
  }
}
