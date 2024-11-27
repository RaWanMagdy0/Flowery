import '../../../core/api/api_result.dart';
import '../../../data/models/auth/requests/login_request_model.dart';
import '../../../data/models/auth/requests/sign_up_request_model.dart';

abstract class AuthRepository {
  Future<Result<String?>> logIn({
    required LoginRequestBodyModel loginRequestBody,
    required bool rememberMe,
  });
  Future<Result<String?>> signUp(SignUpRequestBodyModel signUpRequestBody);
  Future<Result<String?>> forgotPassword({required String email});
  Future<Result<String?>> verifyResetCode({required String resetCode});
}
