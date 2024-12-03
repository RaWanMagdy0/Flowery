import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/core/api/execute_api_call.dart';
import 'package:flowery/data/api/home_api/home_api_manager.dart';
import 'package:flowery/data/data_sources/remote_data_source/home/profile/profile_remote_data_source.dart';
import 'package:flowery/data/models/auth/requests/edite_profile_request_model.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/local/token_manger.dart';
import '../../../../../domain/entities/home_layout/profile/User.dart';

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
      var response = await apiManger.uploadPhoto(photo,token);
      return response;
    });
  }

  }
  Future<String> _getToken() async {
    var token = await TokenManager.getToken();
    if (token == null || token.isEmpty) {
      throw Exception("Token is missing. Please login again.");
    }
    return 'Bearer $token';
  }

