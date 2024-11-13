import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'app_string_error.dart';
class BaseViewModel<T > extends Cubit<T>{
   BaseViewModel(super.initialState);

   String getErrorMassageFromException(Exception ? exception){
      if(exception is DioException){
         return _mapDioExceptionToMessage(exception);
      }else {
         return 'Unknown error occurred';
      }
   }

   String _mapDioExceptionToMessage(DioException dioException) {
      switch (dioException.type) {
         case DioExceptionType.connectionTimeout:
            return AppStringErrors.connectionTimeout;
         case DioExceptionType.sendTimeout:
            return AppStringErrors.sendTimeout;
         case DioExceptionType.receiveTimeout:
            return AppStringErrors.receiveTimeout ;
         case DioExceptionType.badCertificate:
            return AppStringErrors.badCertificate ;
         case DioExceptionType.badResponse:
            return _handleBadResponse(dioException);
         case DioExceptionType.connectionError:
            return AppStringErrors.connectionError ;
         case DioExceptionType.unknown:
            return AppStringErrors.unknown ;
         case DioExceptionType.cancel:
            return "Request cancelled";
         default:
            return AppStringErrors.unknown;
      }
   }
   String _handleBadResponse(DioException exception) {
      final statusCode = exception.response?.statusCode;
      if (statusCode == 400) {
         return exception.response?.data["message"] ?? AppStringErrors.badRequest ;
      } else if (statusCode == 401 || statusCode == 403) {
         return exception.response?.data["message"] ?? AppStringErrors.unauthorized ;
      } else if (statusCode == 404) {
         return  AppStringErrors.notFound;
      } else if (statusCode == 409) {
         return exception.response?.data["message"] ?? AppStringErrors.conflict ;
      } else if (statusCode == 500) {
         return  AppStringErrors.internalServerError ;
      } else {
         return exception.response?.data["message"] ?? AppStringErrors.unknown ;
      }
   }


}