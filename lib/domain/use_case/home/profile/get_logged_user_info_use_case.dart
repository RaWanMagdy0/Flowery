import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/domain/repository/home/profile_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../entities/home_layout/profile/User.dart';

@injectable

class GetLoggedUserInfoUseCase{
  final ProfileRepository profileRepository;
  GetLoggedUserInfoUseCase({required this.profileRepository});
  Future<Result<User?>>invoke()async{
    return await profileRepository.getLoggedUserInfo();
  }
}