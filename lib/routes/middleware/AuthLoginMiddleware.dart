import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/routes/routes_config.dart';

///路由跳转中间鉴权 验证登录访问页面
class AuthLoginMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (!extIsLogin()) {
      return const RouteSettings(
        name: RoutesConfig.LOGIN,
      );
    }

    return null;
  }
}
