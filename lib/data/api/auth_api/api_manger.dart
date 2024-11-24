import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../../core/api/api_const.dart';
import '../../model/auth/requests/sign_up_request_model.dart';
import '../../model/auth/response/sign_up_response_model.dart';
import '../../model/user_model.dart';

part 'api_manger.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiManger {
  @factoryMethod
  factory ApiManger(Dio dio) = _ApiManger;

  @POST(ApiConstants.signUp)
  Future<SignUpResponseModel> signUp(
    @Body() SignUpRequestBodyModel signUpRequestBody,
  );

  @POST(ApiConstants.forgotPasswordApi)
  Future<String?> forgetPassword(@Body() Map<String, dynamic> email);

  @POST(ApiConstants.verifyResetCodeApi)
  Future<String?> verifyResetCode(@Body() Map<String, dynamic> resetCode);

  @POST(ApiConstants.loginApi)
  Future<UserModel?> logIn(@Body() Map<String, dynamic> body);
}
