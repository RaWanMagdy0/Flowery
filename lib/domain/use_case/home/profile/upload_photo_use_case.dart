import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../repository/home/profile_repository.dart';

@injectable

class UploadPhotoUseCase{
  final ProfileRepository profileRepository;
  UploadPhotoUseCase({required this.profileRepository});
  Future<Result<String?>>invoke(XFile photo)async{
    return await profileRepository.uploadPhoto(photo);
  }
}