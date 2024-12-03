import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/data/data_sources/remote_data_source/home/profile/profile_remote_data_source.dart';
import 'package:flowery/data/models/auth/requests/edite_profile_request_model.dart';
import 'package:flowery/domain/entities/home_layout/profile/User.dart';
import 'package:flowery/domain/repository/home/profile_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepositoryImpl({required this.profileRemoteDataSource});
  @override
  Future<Result<User?>> getLoggedUserInfo() {
    return profileRemoteDataSource.getLoggedUserInfo();
  }

  @override
  Future<Result<User?>> editeProfile(EditeProfileRequestModel editeProfile) {
    return profileRemoteDataSource.editProfile(editeProfile);
  }

  @override
  Future<Result<String?>> uploadPhoto(File photo) {
    return profileRemoteDataSource.uploadPhoto(photo);
  }
}
