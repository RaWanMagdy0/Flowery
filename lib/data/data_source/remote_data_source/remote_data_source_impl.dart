import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/core/api/execute_api_call.dart';
import 'package:flowery/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:flowery/data/model/auth/dto/user_dto.dart';
import 'package:flowery/domain/entities/auth/User.dart';
import 'package:injectable/injectable.dart';

import '../../api/api_manger.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  ApiManger apiManger;
  AuthRemoteDataSourceImpl({required this.apiManger});

  @override
  Future<Result<User?>> resetPassword(
      {required String newPassword, required String confirmPassword}) {
    return executeApiCall<User>(apiCall: () async {
      final resPassRes = await apiManger.resetPassword(
          {' newPassword': newPassword}, {" confirmPassword": confirmPassword});
      final userDto = UserDto(token: resPassRes?.token);
      return userDto.toUser();
    });
  }
}
