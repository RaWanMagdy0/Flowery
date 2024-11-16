import 'package:flowery/core/api/api_result.dart';

abstract class AuthRepository {
  Future<Result<String?>> forgotPassword({required String email});
  Future<Result<String?>> verifyResetCode({required String resetCode});
  Future<Result<String?>> logIn(
      {required String email, required String password});
}
