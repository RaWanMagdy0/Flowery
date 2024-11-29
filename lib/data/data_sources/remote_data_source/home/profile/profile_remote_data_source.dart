import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/domain/entities/home_layout/profile/User.dart';

abstract class ProfileRemoteDataSource{
  Future<Result<User?>>getLoggedUserInfo();
}