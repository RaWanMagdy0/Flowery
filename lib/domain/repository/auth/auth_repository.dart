import 'package:flowery/data/models/auth/requests/reset_password_request_model.dart';

import '../../../core/api/api_result.dart';
import '../../../data/models/auth/requests/login_request_model.dart';
import '../../../data/models/auth/requests/sign_up_request_model.dart';

abstract class AuthRepository {
  Future<Result<String?>> logIn({
    required LoginRequestBodyModel loginRequestBody,
    required bool rememberMe,
  });
  Future<Result<String?>> signUp(SignUpRequestBodyModel signUpRequestBody);
  Future<Result<String?>> resetPassword(ResetPasswordRequestBody resetPassword);
  Future<Result<String?>> forgotPassword({required String email});
  Future<Result<String?>> verifyResetCode({required String resetCode});
  //Future<Result<String?>> resetPassword({required String email, required String newPassword,});
  Future<Result<String?>> changePassword({required String currentPassword, required String newPassword,});
}
