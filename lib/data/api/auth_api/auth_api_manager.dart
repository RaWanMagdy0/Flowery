import 'package:dio/dio.dart';
import 'package:flowery/data/models/auth/requests/edite_profile_request_model.dart';
import 'package:flowery/data/models/auth/requests/reset_password_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/api/api_const.dart';
import '../../models/auth/requests/change_password_request_model.dart';
import '../../models/auth/requests/login_request_model.dart';
import '../../models/auth/requests/sign_up_request_model.dart';
import '../../models/auth/response/login_response_model.dart';
import '../../models/auth/response/sign_up_response_model.dart';

part 'auth_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthApiManager {
  @factoryMethod
  factory AuthApiManager(Dio dio) = _AuthApiManager;

  @POST(ApiConstants.login)
  Future<LoginResponseModel> logIn(
      @Body() LoginRequestBodyModel loginRequestBody);

  @POST(ApiConstants.signUp)
  Future<SignUpResponseModel> signUp(
    @Body() SignUpRequestBodyModel signUpRequestBody,
  );

  @POST(ApiConstants.forgotPassword)
  Future<String?> forgetPassword(@Body() Map<String, dynamic> email);

  @POST(ApiConstants.verifyResetCode)
  Future<String?> verifyResetCode(@Body() Map<String, dynamic> resetCode);
  @PUT(ApiConstants.resetPassword)
  Future<String?> resetPassword(@Body() ResetPasswordRequestBody resetPassword);
  @PATCH(ApiConstants.changePassword)
  Future<String?> changePassword(
    @Body() ChangePasswordRequestModel request,
    @Header('Authorization') String token,
  );
  @GET(ApiConstants.logout)
  Future<String?> logout(@Header("Authorization") String token);
}
