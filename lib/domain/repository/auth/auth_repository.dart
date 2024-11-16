import '../../../core/api/api_result.dart';
import '../../../data/models/requests/sign_up_request_model.dart';

abstract class AuthRepository {
  Future<Result<String?>> signUp(SignUpRequestBodyModel signUpRequestBody);
  Future<Result<String?>> forgotPassword({required String email});
  Future<Result<String?>> verifyResetCode({required String resetCode});
}
