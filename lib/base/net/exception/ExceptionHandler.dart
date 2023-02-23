import 'package:dio/dio.dart';

import 'ApiError.dart';
import 'AppException.dart';

class ExceptionHandler {
  static AppException handleDioException(DioError e) {
    switch (e.type) {
      case DioErrorType.connectionTimeout:
        return AppException(ApiError.CONNECT_TIMEOUT.value,
            ApiError.CONNECT_TIMEOUT.code, e.message);
      case DioErrorType.sendTimeout:
        return AppException(ApiError.CONNECT_TIMEOUT.value,
            ApiError.CONNECT_TIMEOUT.code, e.message);
      case DioErrorType.receiveTimeout:
        return AppException(ApiError.RECEIVE_TIMEOUT.value,
            ApiError.RECEIVE_TIMEOUT.code, e.message);
      case DioErrorType.badResponse:
        return AppException(
            ApiError.BAD_RESPONSE.value, ApiError.BAD_RESPONSE.code, e.message);
      case DioErrorType.cancel:
        return AppException(
            ApiError.CANCEL.value, ApiError.CANCEL.code, e.message);
      case DioErrorType.unknown:
        return AppException(
            ApiError.UNKNOW.value, ApiError.UNKNOW.code, e.message);
      default:
        return AppException(
            ApiError.OTHER.value, ApiError.OTHER.code, e.message);
    }
  }

  static AppException handleException(Exception e) {
    return AppException("未知异常类型", -1, e.toString());
  }
}
