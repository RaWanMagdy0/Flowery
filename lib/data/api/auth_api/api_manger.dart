import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../../core/api/api_const.dart';

part 'api_manger.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiManger {
  @factoryMethod
  factory ApiManger(Dio dio) = _ApiManger;

  @POST(ApiConstants.forgotPasswordApi)
  Future<String?> forgetPassword(@Body() Map<String, dynamic> email);
  @POST(ApiConstants.verifyResetCodeApi)
  Future<String?> verifyResetCode(@Body() Map<String, dynamic> resetCode);
  @POST(ApiConstants.loginApi)
  Future<String?> logIn(@Body() Map<String, dynamic> body);
}
