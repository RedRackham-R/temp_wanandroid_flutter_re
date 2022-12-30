import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';

class AppException implements Exception {
  String errorMsg; //错误消息
  int errCode = 0; //错误码
  String? errorLog; //错误日志

  AppException(this.errorMsg, this.errCode, this.errorLog);

  @override
  String toString() {
    return "errCode = $errCode    errorMsg = $errorMsg    errorLog = $errorLog ";
  }
}
