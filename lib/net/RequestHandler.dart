import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:wanandroid_flutter_re/base/net/BaseNetFetchHandler.dart';
import 'package:wanandroid_flutter_re/net/interceptor/WanLoginExpiredInterceptor.dart';
import 'package:wanandroid_flutter_re/net/interceptor/WebCookieInterceptor.dart';

class RequestHandler extends BaseNetFetchHandler {
  final String baseUrl;
  final Interceptor cookieInterceptor;

  RequestHandler({
    required this.baseUrl,
    required this.cookieInterceptor,
  });

  clearAllCookie() {
    if (kIsWeb) {
      final realCookieManager = cookieInterceptor as WebCookieInterceptor;
      realCookieManager.clearCookies();
    } else {
      final realCookieManager = cookieInterceptor as WebCookieInterceptor;
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
      cookieInterceptor,
      WanLoginExpiredInterceptor(),
      //添加cookie管理工具
    ];
  }

  @override
  BaseOptions? setOptions() {
    BaseOptions options = BaseOptions();
    options.baseUrl = baseUrl;
    options.connectTimeout = const Duration(seconds: 5);
    options.receiveTimeout = const Duration(seconds: 3);
    options.responseType = ResponseType.json;
    return options;
  }
}
