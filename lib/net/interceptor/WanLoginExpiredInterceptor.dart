import 'package:dio/dio.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/main.dart';

class WanLoginExpiredInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    //处理公共部分
    final Map<String, dynamic> respDataMap = response.data;
    final errorCode = respDataMap["errorCode"];
    final errorMsg = respDataMap["errorMsg"];
    final data = respDataMap["data"];
    extLog(
        msg:
            "WanLoginExpiredInterceptor 测试解析：${errorCode}  ${errorMsg}  ${data}");

    if (errorCode == -1001) {
      globalAppController.loginOut();
    }

    super.onResponse(response, handler);
  }
}
