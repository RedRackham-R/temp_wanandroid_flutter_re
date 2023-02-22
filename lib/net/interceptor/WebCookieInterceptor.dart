import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/entity/cookie_entity.dart';

import 'package:wanandroid_flutter_re/generated/json/base/json_convert_content.dart';
import 'package:wanandroid_flutter_re/global/CacheManager.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/main.dart';

class WebCookieInterceptor extends Interceptor {
  WebCookieInterceptor() : super();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    await _setCookieFromLocalStore(options, handler);
    Map<String, dynamic> extra = {};
    extra["withCredentials"] = true;
    options.extra = extra;
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    await _saveCookiesToLocal(response)
        .then((_) => handler.next(response))
        .catchError((e, stackTrace) {
      var err = DioError(requestOptions: response.requestOptions, error: e);
      err.stackTrace = stackTrace;
      handler.reject(err, true);
    });
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response != null) {
      await _saveCookiesToLocal(err.response!)
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

  Future<void> _saveCookiesToLocal(Response response) async {
    var cookies = response.headers[HttpHeaders.setCookieHeader];
    if (cookies != null) {
      List<Cookie> respCookies =
          cookies.map((str) => Cookie.fromSetCookieValue(str)).toList();

      String? localCookiesStr = await CacheManager.fetch_web_local_cookie();

      if (localCookiesStr.isNullOrEmpty()) {
        List<CookieEntity> list = [];
        for (var element in respCookies) {
          final entity = CookieEntity();
          entity.name = element.name;
          entity.value = element.value;
          list.add(entity);
        }
        await CacheManager.save_web_local_cookie(jsonEncode(list));
      } else {
        try {
          List<CookieEntity>? localList =
              jsonConvert.convertListNotNull<CookieEntity>(
                  jsonDecode(localCookiesStr!) as List<dynamic>);

          for (var respCookie in respCookies) {
            List<CookieEntity> toRemove = [];
            for (var element in localList!) {
              if (element.name == respCookie.name) {
                toRemove.add(element);
              }
            }
            localList.removeWhere((e) => toRemove.contains(e));
            final entity = CookieEntity();
            entity.name = respCookie.name;
            entity.value = respCookie.value;
            localList.add(entity);
          }
          await CacheManager.save_web_local_cookie(jsonEncode(localList));
        } catch (exception) {
          extLog(msg: "_saveCookiesToLocal error ${exception}");
          await globalAppController.loginOut();
          extRunWithLogin(onLogin: () {});
        }
      }
    }
  }

  Future<void> _setCookieFromLocalStore(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? localCookiesStr = await CacheManager.fetch_web_local_cookie();
    if (!localCookiesStr.isNullOrEmpty()) {
      try {
        List<CookieEntity>? cookies =
            jsonConvert.convertListNotNull<CookieEntity>(
                jsonDecode(localCookiesStr!) as List<dynamic>);

        options.headers[HttpHeaders.cookieHeader] = cookies!
            .map((cookie) => '${cookie.name}=${cookie.value}')
            .join('; ');
      } catch (exception) {
        await globalAppController.loginOut();
        extLog(msg: "_setCookieFromLocalStore error ${exception}");
        extRunWithLogin(onLogin: () {});
      }
    }
  }

  clearCookies() async {
    CacheManager.save_web_local_cookie("");
  }
}
