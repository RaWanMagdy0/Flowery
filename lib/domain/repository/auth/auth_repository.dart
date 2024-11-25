import 'package:flowery/data/model/user_model.dart';

import '../../../core/api/api_result.dart';
import '../../../data/model/auth/requests/sign_up_request_model.dart';

abstract class AuthRepository {
  Future<Result<String?>> signUp(SignUpRequestBodyModel signUpRequestBody);
  Future<Result<String?>> forgotPassword({required String email});
  Future<Result<String?>> verifyResetCode({required String resetCode});
  Future<Result<UserModel?>> logIn(
      {required String email, required String password});
}
