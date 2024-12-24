import 'package:image_picker/image_picker.dart';

import '../../../../../core/api/api_result.dart';
import '../../../../../domain/entities/home_layout/profile/user.dart';
import '../../../../models/auth/requests/edite_profile_request_model.dart';

abstract class ProfileRemoteDataSource {
  Future<Result<User?>> getLoggedUserInfo();
  Future<Result<User?>> editProfile(EditeProfileRequestModel editeProfile);
  Future<Result<String?>> uploadPhoto(XFile photo);
}
