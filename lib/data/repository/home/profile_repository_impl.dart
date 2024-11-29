import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/data/data_sources/remote_data_source/home/profile/profile_remote_data_source.dart';
import 'package:flowery/domain/entities/home_layout/profile/User.dart';
import 'package:flowery/domain/repository/home/profile_repository.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository{
  final ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepositoryImpl({required this.profileRemoteDataSource});
  @override
  Future<Result<User?>> getLoggedUserInfo() {
  return profileRemoteDataSource.getLoggedUserInfo();
  }

}