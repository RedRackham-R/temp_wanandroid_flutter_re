import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/global/ext/ThemeExt.dart';

import 'package:wanandroid_flutter_re/ui/weight/AvatarPickerWidget.dart';
import 'package:wanandroid_flutter_re/ui/weight/ColorPickerWidget.dart';

///显示颜色选择器
extShowMaterialColorPickerDialog({
  required Function(Color color) onComfrim,
  required Function onCancel,
  required ValueChanged<ColorSwatch?> onMainColorChange,
}) {
  extShowCustomDialog(
    barrierDismissible: false,
    widget: Container(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(
          left: 26.w,
          right: 26.w,
        ),
        child: ColorPickerWidget(
          onComfrim: onComfrim,
          onCancel: onCancel,
          onMainColorChange: onMainColorChange,
        ),
      ),
    ),
  );
}

///显示头像选择dialog
extShowAvatarPickerDialog() {
  extShowCustomDialog(
    widget: Container(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(
          left: 18.w,
          right: 18.w,
        ),
        child: AvatarPickerWidget(),
      ),
    ),
  );
}


///显示BottomSheet底部弹窗详情说明
extShowBottomMessageDialog(
    {required BuildContext context, required String text}) {
  showModalBottomSheet(
    context: context,
    builder: (builder) {
      return SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: extCurrentTheme().scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0))),
          child: Container(
            margin: EdgeInsets.only(
              top: 18.h,
              bottom: 18.h,
              right: 12.w,
              left: 12.w,
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.sp,
                color: extUseColorWithDarkMod(
                  targetColor: extCurrentTheme().textTheme.bodyText1!.color!,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

///显示提示确认dialog
extShowComfrimDialog(
    {String? title = "",
    String? content = "",
    bool barrierDismissible = false,
    required VoidCallback onConfirm,
    required VoidCallback cancel}) {
  Get.defaultDialog(
      title: title!,
      middleText: content!,
      //监听返回键不可退出
      onWillPop: () async {
        return barrierDismissible;
      },
      barrierDismissible: barrierDismissible,
      onConfirm: onConfirm,
      onCancel: cancel,
      textConfirm: "确认",
      textCancel: "取消");
}

///显示loadingDialog
extShowLoadingDialog({
  String? title = "",
  String? msg = "正在加载...",
}) {
  Get.defaultDialog(
    //监听返回键不可退出
    onWillPop: () async {
      return false;
    },
    barrierDismissible: false,
    content: Container(
      alignment: Alignment.center,
      height: 160.h,
      width: 120.w,
      child: SizedBox(
        height: 80.h,
        width: 80.w,
        child: CircularProgressIndicator(
          //加载进度条
          backgroundColor: extCurrentTheme().scaffoldBackgroundColor,
          valueColor: AlwaysStoppedAnimation(extCurrentTheme().primaryColor),
        ),
      ),
    ),
  );
}

///关闭dialog
extDismissDialog() {
  final isOpen = Get.isDialogOpen;
  if (isOpen != null && isOpen) {
    Navigator.of(Get.overlayContext!).pop();
  }
}

///显示自定义dialog
extShowCustomDialog({
  required Widget widget,
  bool barrierDismissible = true,
  Color barrierColor = Colors.black54,
}) {
  Get.dialog(
    widget,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
  );
}
