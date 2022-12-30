import 'dart:async';
import 'dart:html';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:wanandroid_flutter_re/generated/json/base/json_convert_content.dart';

class WebCookieManager extends Interceptor {
  WebCookieManager() : super();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    window.cookieStore?.getAll().then((cookies) {
      var cookie = _getCookies(cookies);
      if (cookie.isNotEmpty) {
        options.headers[HttpHeaders.cookieHeader] = cookie;
      }
      handler.next(options);
    }).catchError((e, stackTrace) {
      var err = DioError(requestOptions: options, error: e);
      err.stackTrace = stackTrace;
      handler.reject(err, true);
    });
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _saveCookiesToCookieStore(response)
        .then((_) => handler.next(response))
        .catchError((e, stackTrace) {
      var err = DioError(requestOptions: response.requestOptions, error: e);
      err.stackTrace = stackTrace;
      handler.reject(err, true);
    });
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      _saveCookiesToCookieStore(err.response!)
          .then((_) => handler.next(err))
          .catchError((e, stackTrace) {
        var _err = DioError(
          requestOptions: err.response!.requestOptions,
          error: e,
        );
        _err.stackTrace = stackTrace;
        handler.next(_err);
      });
    } else {
      handler.next(err);
    }
  }

  Future<void> _saveCookiesToCookieStore(Response response) async {
    var cookies = response.headers[HttpHeaders.setCookieHeader];

    if (cookies != null) {
      List<Cookie> cookieList =
          cookies.map((str) => Cookie.fromSetCookieValue(str)).toList();

      for (var element in cookieList) {
        window.cookieStore?.set(element.name, element.value);
      }
    }
  }

  String _getCookies(List<dynamic> value) {
    List<Cookie?>? list = jsonConvert.convertList<Cookie>(value);
    List<Cookie> cookies = [];
    list?.forEach((element) {
      if (element != null) {
        cookies.add(element);
      }
    });
    return cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
  }
}
