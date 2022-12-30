import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/main.dart';
import 'package:wanandroid_flutter_re/routes/routes_config.dart';
import 'package:wanandroid_flutter_re/theme/WanThemes.dart';


extRunWithLogin({
  required Function onLogin,
  Function? onNotLogin,
  bool toLoginPage = true,
}) {
  if (extIsLogin()) {
    ///已登录的逻辑
    onLogin();
  } else {
    ///增加处理没登陆的功能逻辑
    if (onNotLogin != null) {
      onNotLogin();
    }
    if (toLoginPage) {
      Get.toNamed(RoutesConfig.LOGIN);
    }
  }
}

///登录检测
bool extIsLogin() {
  return globalAppController.userState.isLogin();
}

///判断是否跟随系统
bool extIsWithSystemMod() {
  return globalAppController.settings.withSystemMod;
}

///判断是否是黑夜模式
bool extIsDarkMod() {
  return globalAppController.settings.darkMod;
}

///判断平台当前是否是深色模式
bool extIsPlatformDarkMod() {
  return Get.isPlatformDarkMode;
}

ThemeData extCurrentTheme() {
  return WanThemes.instance.current;
}
