import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/domain/entities/auth/User.dart';
import 'package:flowery/domain/repo/auth/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../../data_source/remote_data_source/remote_data_source.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource dataSource;
  AuthRepoImpl({required this.dataSource});
  @override
  Future<Result<User?>> resetPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    return await dataSource.resetPassword(
      newPassword: newPassword,
     confirmPassword: confirmPassword
    );
  }
}
