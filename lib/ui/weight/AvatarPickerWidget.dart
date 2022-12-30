import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/global/ext/DialogExt.dart';
import 'package:wanandroid_flutter_re/global/ext/ThemeExt.dart';
import 'package:wanandroid_flutter_re/main.dart';

///头像选择器组件
class AvatarPickerWidget extends StatefulWidget {
  AvatarPickerWidget({Key? key}) : super(key: key);

  var _selectAvatar = globalAppController.settings.avatar;

  @override
  State<AvatarPickerWidget> createState() => _AvatarPickerWidgetState();
}

class _AvatarPickerWidgetState extends State<AvatarPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: extCurrentTheme().scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ///title
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  color: extCurrentTheme().appBarTheme.backgroundColor!,
                  padding: EdgeInsets.all(
                    12.w,
                  ),
                  child: Text(
                    "选择头像",
                    style: _creatTextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(color: Colors.grey,height: 0.2.h,),
              ),
            ],
          ),

          ///头像预览
          Container(
            color: extCurrentTheme().primaryColor,
            alignment: Alignment.center,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 24.h,
                ),
                Image.asset(
                  widget._selectAvatar,
                  height: 56.h,
                  width: 56.h,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(child: SizedBox()),
                    Text(
                      "等级：xxx  排名：xxx",
                      style: _creatTextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
                SizedBox(
                  height: 24.h,
                ),
              ],
            ),
          ),

          ///头像列表
          Container(
            color: extCurrentTheme().cardColor,
            height: 220.h,
            child: EasyRefresh(
              child: GridView.builder(
                itemCount: 40,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 32.h,
                  mainAxisSpacing: 32.h,
                  crossAxisCount: 4, //每行五列
                  // childAspectRatio: 1.1, //显示区域宽高相等
                ),
                itemBuilder: (BuildContext context, int index) {
                  return _creatAvatarItem(index: index);
                },
              ),
            ),
          ),

          ///确定
          Row(
            children: [
              const Expanded(child: SizedBox()),
              TextButton(
                onPressed: () {
                  _onCancel();
                },
                child: Text(
                  "取消",
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: extCurrentTheme().textTheme.headline1!.color!),
                ),
              ),
              SizedBox(
                width: 24.w,
              ),
              TextButton(
                onPressed: () {
                  _onComfrim();
                },
                child: Text(
                  "确认",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: extUseColorWithDarkMod(
                      targetColor: extCurrentTheme().primaryColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _creatTextStyle({required double fontSize}) {
    return TextStyle(
      decoration: TextDecoration.none,
      fontSize: fontSize,
      color: extCurrentTheme().primaryTextTheme.titleMedium!.color!,
    );
  }

  Widget _creatAvatarItem({
    required int index,
  }) {
    final avatar = "assets/images/avatars/avatar${index + 1}.png";
    if (widget._selectAvatar == avatar) {
      final borderSide = BorderSide(
        // 设置单侧边框的样式
        color: extUseColorWithDarkMod(
          targetColor: extCurrentTheme().primaryColor,
        ),
        width: 2.w,
        style: BorderStyle.solid,
      );
      return GestureDetector(
        onTap: () {
          _onSelectAvatar(avatar);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: borderSide,
              top: borderSide,
              right: borderSide,
              bottom: borderSide,
            ),
          ),
          child: Image.asset(avatar),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          _onSelectAvatar(avatar);
        },
        child: Image.asset(avatar),
      );
    }
  }

  _onSelectAvatar(String avatar) {
    setState(() {
      widget._selectAvatar = avatar;
    });
  }

  _onComfrim() {
    globalAppController.updateSettingsAvatar = widget._selectAvatar;
    extDismissDialog();
  }

  _onCancel() {
    extDismissDialog();
  }
}
