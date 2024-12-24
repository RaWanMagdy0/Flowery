import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../domain/entities/home_layout/profile/user.dart';
import '../../../domain/repository/home/profile_repository.dart';
import '../../data_sources/remote_data_source/home/profile/profile_remote_data_source.dart';
import '../../models/auth/requests/edite_profile_request_model.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepositoryImpl({required this.profileRemoteDataSource});
  @override
  Future<Result<User?>> getLoggedUserInfo() {
    return profileRemoteDataSource.getLoggedUserInfo();
  }

  @override
  Future<Result<User?>> editeProfile(EditeProfileRequestModel editeProfile) {
    return profileRemoteDataSource.editProfile(editeProfile);
  }

  @override
  Future<Result<String?>> uploadPhoto(XFile photo) {
    return profileRemoteDataSource.uploadPhoto(photo);
  }
}
