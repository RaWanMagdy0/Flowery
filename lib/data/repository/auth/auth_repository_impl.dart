import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/domain/repository/auth/auth_repository.dart';
import 'package:injectable/injectable.dart';
import '../../data_source/remote_data_source/auth/auth_remote_data_source.dart';
import '../../model/auth/requests/sign_up_request_model.dart';
import '../../model/user_model.dart';

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

  @override
  Future<Result<UserModel?>> logIn(
      {required String email, required String password}) {
    return dataSource.logIn(password: password, email: email);
  }
}
