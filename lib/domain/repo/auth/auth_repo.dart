import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/domain/entities/auth/User.dart';

abstract class AuthRepo {
  Future<Result<User?>> resetPassword(
      {required String newPassword, required String confirmPassword});
}
