import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../data/models/requests/sign_up_request_model.dart';
import '../../../repository/auth/auth_repository.dart';

@injectable
class SignUpUseCase {
  final AuthRepository _repo;

  SignUpUseCase(this._repo);

  Future<Result<String?>> invoke(SignUpRequestBodyModel userData) async {
    return await _repo.signUp(userData);
  }
}
