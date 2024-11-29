
import '../../../../core/api/api_result.dart';
import '../../../models/auth/requests/login_request_model.dart';
import '../../../models/auth/requests/reset_password_request_model.dart';
import '../../../models/auth/requests/sign_up_request_model.dart';
import '../../../models/auth/response/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<Result<LoginResponseModel?>> logIn(
      LoginRequestBodyModel loginRequestBody);
  Future<Result<String?>> signUp(SignUpRequestBodyModel signUpRequestBody);
  Future<Result<String?>> forgotPassword({required String email});
  Future<Result<String?>> verifyResetCode({required String resetCode});
  Future<Result<String?>> resetPassword(ResetPasswordRequestBody resetPassword);
}
