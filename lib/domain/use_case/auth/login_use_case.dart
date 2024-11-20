import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../data/model/user_model.dart';
import '../../repository/auth/auth_repository.dart';

@Injectable()
class LogInUseCase {
  AuthRepository repository;

  LogInUseCase(this.repository);

  Future<Result<UserModel?>> invokeLogIn(
      {required String email, required String password}) {
    return repository.logIn(email: email, password: password);
  }
}
