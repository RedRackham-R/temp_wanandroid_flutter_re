import 'package:dio/dio.dart';

import 'ApiError.dart';
import 'AppException.dart';

class ExceptionHandler {
  static AppException handleDioException(DioError e) {
    switch (e.type) {
      case DioErrorType.connectTimeout:
        {
          return AppException(ApiError.CONNECT_TIMEOUT.value,
              ApiError.CONNECT_TIMEOUT.code, e.message);
        }
      case DioErrorType.sendTimeout:
        return AppException(ApiError.CONNECT_TIMEOUT.value,
            ApiError.CONNECT_TIMEOUT.code, e.message);
      case DioErrorType.receiveTimeout:
        return AppException(ApiError.RECEIVE_TIMEOUT.value,
            ApiError.RECEIVE_TIMEOUT.code, e.message);
      case DioErrorType.response:
        return AppException(
            ApiError.RESPONSE.value, ApiError.RESPONSE.code, e.message);
      case DioErrorType.cancel:
        return AppException(
            ApiError.CANCEL.value, ApiError.CANCEL.code, e.message);
      case DioErrorType.other:
        return AppException(
            ApiError.OTHER.value, ApiError.OTHER.code, e.message);
      default:
        return AppException(
            ApiError.OTHER.value, ApiError.OTHER.code, e.message);
    }
  }

  static AppException handleException(Exception e) {
    return AppException("未知异常类型", -1, e.toString());
  }
}
