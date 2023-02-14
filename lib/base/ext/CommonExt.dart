import 'package:common_utils/common_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

///公共拓展函数 非业务功能

extension StringExt on String? {
  ///检测String是null或者是空的
  bool isNullOrEmpty() => (this == null || this!.isEmpty);

  bool isNotEmpty() => (this != null && this!.isNotEmpty);
}

extension BoolExt on List? {
  ///检测list是null或者是空的
  bool isNullOrEmpty() {
    return (this == null || this!.isEmpty);
  }
}

/// 关闭键盘并保留焦点
Future<void> extFocusHideKeyboard() async {
  await SystemChannels.textInput.invokeMethod('TextInput.hide');
}

/// 关闭键盘并失去焦点
Future<void> extUnfocusHideKeyboard() async {
  FocusManager.instance.primaryFocus?.unfocus();
}

///显示toast
extShowToast(
  String msg, {
  toastLength = Toast.LENGTH_SHORT,
  gravity = ToastGravity.BOTTOM,
  timeInSecForIosWeb = 1,
  backgroundColor = Colors.black45,
  textColor = Colors.white,
  fontSize = 16.0,
}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength,
        gravity: gravity,
        timeInSecForIosWeb: timeInSecForIosWeb,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: fontSize);

///拓展日志打印函数
extLog({
  required String msg,
  String? tag,
}) {
  if (defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android) {
    LogUtil.e("$tag $msg");
  } else if (defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.windows) {
    print("tag:$tag msg:$msg");
  } else {
    print("tag:$tag msg:$msg");
  }
}
