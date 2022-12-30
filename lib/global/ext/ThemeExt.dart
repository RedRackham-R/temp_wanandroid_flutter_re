import 'package:flutter/material.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';




///判断当前是否是黑夜模式，不是的话就把设置的color返回回去
Color extUseColorWithDarkMod(
    {required Color targetColor, Color? darkModColor}) {
  if (extIsDarkMod()) {
    if (darkModColor == null) {
      final color = extCurrentTheme().textTheme.headline1!.color!;
      return Color.fromARGB(0xff, color.alpha, color.green, color.blue);
    } else {
      return darkModColor;
    }
  } else {
    return targetColor;
  }
}
