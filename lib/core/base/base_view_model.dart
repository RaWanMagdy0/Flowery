import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_string_error.dart';

class BaseViewModel<T> extends Cubit<T> {
  BaseViewModel(super.initialState);

  String getErrorMassageFromException(Exception? exception) {
    if (exception is DioException) {
      return _mapDioExceptionToMessage(exception);
    } else {
      return 'An unknown error occurred';
    }
  }

  String _mapDioExceptionToMessage(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return AppStringErrors.connectionTimeout;
      case DioExceptionType.sendTimeout:
        return AppStringErrors.sendTimeout;
      case DioExceptionType.receiveTimeout:
        return AppStringErrors.receiveTimeout;
      case DioExceptionType.badCertificate:
        return AppStringErrors.badCertificate;
      case DioExceptionType.badResponse:
        return _handleBadResponse(dioException);
      case DioExceptionType.connectionError:
        return AppStringErrors.connectionError;

      case DioExceptionType.cancel:
        return dioException.message ?? 'Request cancelled';
      default:
        return AppStringErrors.unknown;
    }
  }

  String _handleBadResponse(DioException exception) {
    final statusCode = exception.response?.statusCode;
    final responseData = exception.response?.data;
    if (responseData is Map && responseData.containsKey("error")) {
      return responseData["error"];
    } else if (responseData is Map && responseData.containsKey("message")) {
      return responseData["message"];
    }
    if (statusCode == 400) {
      return AppStringErrors.badRequest;
    } else if (statusCode == 401 || statusCode == 403) {
      return AppStringErrors.unauthorized;
    } else if (statusCode == 404) {
      return AppStringErrors.notFound;
    } else if (statusCode == 409) {
      return AppStringErrors.conflict;
    } else if (statusCode == 500) {
      return AppStringErrors.internalServerError;
    } else {
      return AppStringErrors.unknown;
    }
  }
}
