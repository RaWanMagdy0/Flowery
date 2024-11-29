import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/core/api/execute_api_call.dart';
import 'package:flowery/data/api/home_api/home_api_manager.dart';
import 'package:flowery/data/data_sources/remote_data_source/home/profile/profile_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/local/token_manger.dart';
import '../../../../../domain/entities/home_layout/profile/User.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource{
  HomeApiManger apiManger;
  ProfileRemoteDataSourceImpl({required this.apiManger});

  @override
  Future<Result<User?>> getLoggedUserInfo()async {
   return await executeApiCall<User?>(()async{
     var token = await TokenManager.getToken();
     if (token == null || token.isEmpty) {
       throw Exception("Token is missing. Please login again.");
     }
     token = 'Bearer $token';
     var appUserModel = await apiManger.getLoggedUserInfo(token);
     return appUserModel?.toUser();

   });
  }

}