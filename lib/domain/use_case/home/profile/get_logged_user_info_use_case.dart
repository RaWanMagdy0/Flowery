import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../entities/home_layout/profile/user.dart';
import '../../../repository/home/profile_repository.dart';

@injectable
class GetLoggedUserInfoUseCase {
  final ProfileRepository profileRepository;
  GetLoggedUserInfoUseCase({required this.profileRepository});
  Future<Result<User?>> invoke() async {
    return await profileRepository.getLoggedUserInfo();
  }
}
