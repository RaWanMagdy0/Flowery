import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../data/models/auth/requests/login_request_model.dart';
import '../../repository/auth/auth_repository.dart';

@Injectable()
class LogInUseCase {
  AuthRepository repository;

  LogInUseCase(this.repository);

  Future<Result<String?>> invoke({
    required String email,
    required String password,
    required bool rememberMe,
  }) {
    final LoginRequestBodyModel body = LoginRequestBodyModel(
      email: email,
      password: password,
    );
    return repository.logIn(
      loginRequestBody: body,
      rememberMe: rememberMe,
    );
  }
}
