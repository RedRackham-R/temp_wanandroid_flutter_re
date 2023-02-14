import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:wanandroid_flutter_re/base/net/BaseNetFetchHandler.dart';
import 'package:wanandroid_flutter_re/net/interceptor/WebCookieManager.dart';

class RequestHandler extends BaseNetFetchHandler {
  final String baseUrl;
  final Interceptor cookieManager;

  RequestHandler({
    required this.baseUrl,
    required this.cookieManager,
  });

  clearAllCookie() {
    if (kIsWeb) {
      final realCookieManager = cookieManager as WebWanCookieManager;
      realCookieManager.clearCookies();
    } else {
      final realCookieManager = cookieManager as WebWanCookieManager;
      realCookieManager.clearCookies();
    }
  }

  @override
  HttpClientAdapter? setHttpClientAdapter() {
    return null;
  }

  @override
  List<Interceptor>? setInterceptors() {
    return <Interceptor>[
      //添加日志输出拦截器
      LogInterceptor(),
      cookieManager,
      //添加cookie管理工具
    ];
  }

  @override
  BaseOptions? setOptions() {
    BaseOptions options = BaseOptions();
    options.baseUrl = baseUrl;
    options.connectTimeout = 5000;
    options.receiveTimeout = 3000;
    options.responseType = ResponseType.json;
    return options;
  }
}
