import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flowery/data/models/home/profile/custom_form_data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';

import '../../../../../core/api/api_result.dart';
import '../../../../../core/api/execute_api_call.dart';
import '../../../../../core/local/token_manger.dart';
import '../../../../../domain/entities/home_layout/profile/User.dart';
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
  Future<Result<String?>> uploadPhoto(File photo) async {
    return await executeApiCall<String?>(() async {
      var token = await _getToken();
      final mimeType = lookupMimeType(photo.path);
      print(mimeType);
      CustomFormData formData = CustomFormData(fields: {
        "photo": CustomMultipartFile(
          path: photo.path,
          filename: photo.path.split("/").last,
        ),
      });
      var response =
          await apiManger.uploadPhoto(token, photo);
      return response;
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
