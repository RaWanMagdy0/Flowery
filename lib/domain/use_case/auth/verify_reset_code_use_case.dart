import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../repository/auth/auth_repository.dart';

@injectable
class VerifyResetCodeUseCase {
  AuthRepository repository;
  VerifyResetCodeUseCase({required this.repository});
  Future<Result<String?>> invoke({required String resetCode}) {
    return repository.verifyResetCode(resetCode: resetCode);
  }
}
