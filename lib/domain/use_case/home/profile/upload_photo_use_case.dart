import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../repository/home/profile_repository.dart';

@injectable

class UploadPhotoUseCase{
  final ProfileRepository profileRepository;
  UploadPhotoUseCase({required this.profileRepository});
  Future<Result<String?>>invoke(File photo)async{
    return await profileRepository.uploadPhoto(photo);
  }
}
