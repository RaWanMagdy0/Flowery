
import 'package:flowery/core/api/api_result.dart';

Future<Result<T>>executeApiCall<T>({
  required Future<T>Function()apiCall})async{
  try{
    var result=await apiCall.call();
    return Success(data: result);
  }on Exception catch (e){
    return Fail(exception: e);
  }
}