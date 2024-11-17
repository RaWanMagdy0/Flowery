import 'package:flowery/core/api/api_result.dart';

import '../../../domain/entities/auth/User.dart';

abstract class AuthRemoteDataSource {
  Future<Result<User?>> resetPassword(
      {required String newPassword, required String confirmPassword});
}
