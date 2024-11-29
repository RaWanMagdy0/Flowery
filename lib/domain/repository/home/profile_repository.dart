import 'package:flowery/core/api/api_result.dart';

import '../../entities/home_layout/profile/User.dart';

abstract class ProfileRepository{
  Future<Result<User?>>getLoggedUserInfo();
}