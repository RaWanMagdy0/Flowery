import 'package:flowery/core/api/api_result.dart';

abstract class AuthRemoteDataSource{
  Future<Result<String?>>forgotPassword({
   required String email
});
}