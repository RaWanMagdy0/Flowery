import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/data/models/auth/requests/edite_profile_request_model.dart';

import '../../entities/home_layout/profile/User.dart';

abstract class ProfileRepository{
  Future<Result<User?>>getLoggedUserInfo();
  Future<Result<User?>>editeProfile(EditeProfileRequestModel editeProfile);
  Future<Result<String?>>uploadPhoto(File imageFile);

}