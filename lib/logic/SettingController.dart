import 'package:flutter/material.dart';
import 'package:wanandroid_flutter_re/base/logic/BaseController.dart';
import 'package:wanandroid_flutter_re/global/Constant.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';


class SettingsController extends BaseController {
  ///主题颜色
  Color _curColor = extCurrentTheme().primaryColor;

  Color get curColor => _curColor;

  set updatePageColor(Color color) {
    _curColor = color;
    update([Constant.SETTINGS_UPDATE_PAGE_COLOR]);
  }
}
