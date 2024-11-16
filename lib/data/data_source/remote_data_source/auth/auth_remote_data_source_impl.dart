import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/core/api/execute_api_call.dart';
import 'package:injectable/injectable.dart';

import '../../../api/auth_api/api_manger.dart';
import 'auth_remote_data_source.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  ApiManger apiManger;
  AuthRemoteDataSourceImpl({required this.apiManger});
  @override
  Future<Result<String?>> forgotPassword({required String email}) {
    return executeApiCall<String?>(apiCall: () async {
      String? message = await apiManger.forgetPassword({'email': email});
      return message;
    });
  }

  @override
  Future<Result<String?>> verifyResetCode({required String resetCode}) {
    return executeApiCall<String?>(apiCall: () async {
      String? message =
          await apiManger.verifyResetCode({"resetCode": resetCode});
      return message;
    });
  }

  @override
  Future<Result<String?>> logIn(
      {required String email, required String password}) {
    return executeApiCall<String?>(apiCall: () async {
      String? message =
          await apiManger.logIn({"email": email, "password": password});
      return message;
    });
  }
}
