import '../../../core/api/api_result.dart';
import '../../models/requests/sign_up_request_model.dart';
import '../../../domain/repository/auth/auth_repository.dart';
import 'package:injectable/injectable.dart';

import '../../data_source/remote_data_source/auth/auth_remote_data_source.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource dataSource;

  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<Result<String?>> signUp(SignUpRequestBodyModel signUpRequestBody) {
    return dataSource.signUp(signUpRequestBody);
  }

  @override
  Future<Result<String?>> forgotPassword({required String email}) {
    return dataSource.forgotPassword(email: email);
  }

  @override
  Future<Result<String?>> verifyResetCode({required String resetCode}) {
    return dataSource.verifyResetCode(resetCode: resetCode);
  }
}
