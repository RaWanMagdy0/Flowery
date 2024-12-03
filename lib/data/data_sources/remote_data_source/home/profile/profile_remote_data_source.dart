import 'dart:io';
import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/domain/entities/home_layout/profile/User.dart';
import '../../../../models/auth/requests/edite_profile_request_model.dart';

abstract class ProfileRemoteDataSource{
  Future<Result<User?>>getLoggedUserInfo();
  Future<Result<User?>>editProfile(EditeProfileRequestModel editeProfile);
  Future<Result<String?>>uploadPhoto(File photo);

}