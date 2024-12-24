import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../../core/api/api_const.dart';
import '../../../../../core/api/api_result.dart';
import '../../../../../core/api/execute_api_call.dart';
import '../../../../../core/local/token_manger.dart';
import '../../../../../domain/entities/home_layout/profile/user.dart';
import '../../../../api/home_api/home_api_manager.dart';
import '../../../../models/auth/requests/edite_profile_request_model.dart';
import 'profile_remote_data_source.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  HomeApiManger apiManger;
  ProfileRemoteDataSourceImpl({required this.apiManger});

  @override
  Future<Result<User?>> getLoggedUserInfo() async {
    return await executeApiCall<User?>(() async {
      var token = await _getToken();
      var appUserModel = await apiManger.getLoggedUserInfo(token);
      return appUserModel?.toUser();
    });
  }

  @override
  Future<Result<User?>> editProfile(
      EditeProfileRequestModel editeProfile) async {
    return await executeApiCall<User?>(() async {
      var token = await _getToken();
      var appUserModel = await apiManger.editProfile(token, editeProfile);
      return appUserModel?.toUser();
    });
  }

  @override
  Future<Result<String?>> uploadPhoto(XFile photo) async {
    return await executeApiCall<String?>(() async {
      var token = await _getToken();
      var photoFile = await MultipartFile.fromFile(photo.path);
      print(photo.path);
      var formData = FormData.fromMap({
        "photo": [photoFile],
      });
      final dio = Dio()
        ..interceptors.addAll(
          [
            !kReleaseMode
                ? PrettyDioLogger(
                    requestBody: true,
                    requestHeader: true,
                    responseHeader: true,
                  )
                : const Interceptor(),
          ],
        );
      final response = await dio.put(
        "${ApiConstants.baseUrl}${ApiConstants.uploadPhoto}",
        data: formData,
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );
      return response.data;
    });
  }

  Future<String> _getToken() async {
    var token = await TokenManager.getToken();
    if (token == null || token.isEmpty) {
      throw Exception("Token is missing. Please login again.");
    }
    return 'Bearer $token';
  }
}
