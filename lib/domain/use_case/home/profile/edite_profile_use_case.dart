import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../data/models/auth/requests/edite_profile_request_model.dart';
import '../../../entities/home_layout/profile/User.dart';
import '../../../repository/home/profile_repository.dart';

@injectable
class EditeProfileUseCase {
  final ProfileRepository profileRepository;
  EditeProfileUseCase({required this.profileRepository});
  Future<Result<User?>> invoke(EditeProfileRequestModel editeProfile) async {
    return await profileRepository.editeProfile(editeProfile);
  }
}
