import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../core/api/api_const.dart';
import '../../domain/entities/auth/User.dart';
part 'api_manger.g.dart'; // This file will be generated.

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiManger {
  @factoryMethod
  factory ApiManger(Dio dio) = _ApiManger;

  @POST(ApiConstants.forgotPasswordApi)
  Future<String?> forgetPassword(@Body() Map<String, dynamic> email);

  @PUT(ApiConstants.resetPasswordEndpoint)
  Future<User?> resetPassword(@Body() Map<String, dynamic> email, newPassword);
}
