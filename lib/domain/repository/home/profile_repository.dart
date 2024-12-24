import 'package:image_picker/image_picker.dart';

import '../../../core/api/api_result.dart';
import '../../../data/models/auth/requests/edite_profile_request_model.dart';
import '../../entities/home_layout/profile/user.dart';

abstract class ProfileRepository {
  Future<Result<User?>> getLoggedUserInfo();
  Future<Result<User?>> editeProfile(EditeProfileRequestModel editeProfile);
  Future<Result<String?>> uploadPhoto(XFile photo);
}
