import 'package:flowery/core/api/api_result.dart';
import 'package:injectable/injectable.dart';
import '../entities/auth/User.dart';
import '../repo/auth/auth_repo.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepo authRepo;

  ResetPasswordUseCase({required this.authRepo});

  Future<Result<User?>> invoke(
      {required String confirmPassword, required String newPassword}) {
    return authRepo.resetPassword(
        confirmPassword: confirmPassword, newPassword: newPassword);
  }
}
