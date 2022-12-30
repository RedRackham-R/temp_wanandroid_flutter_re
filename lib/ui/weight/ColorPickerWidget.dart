import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/global/ext/DialogExt.dart';
import 'package:wanandroid_flutter_re/global/ext/ThemeExt.dart';
import 'package:wanandroid_flutter_re/theme/WanThemes.dart';


class ColorPickerWidget extends StatefulWidget {
  var _selectColor = extCurrentTheme().primaryColor;
  Function(Color color) onComfrim;
  Function onCancel;
  ValueChanged<ColorSwatch?> onMainColorChange;

  ColorPickerWidget({
    required this.onComfrim,
    required this.onCancel,
    required this.onMainColorChange,
    Key? key,
  }) : super(key: key);

  @override
  State<ColorPickerWidget> createState() => _AvatarPickerWidgetState();
}

class _AvatarPickerWidgetState extends State<ColorPickerWidget> {
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
                  color: widget._selectColor,
                  padding: EdgeInsets.all(
                    12.w,
                  ),
                  child: Text(
                    "选择主题颜色",
                    style: _creatTextStyle(
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          MaterialColorPicker(
            allowShades: false,
            // default true
            selectedColor: _getMaterialColor(
              widget._selectColor,
            ),
            onMainColorChange: (ColorSwatch? color) => {
              widget.onMainColorChange(color),
              setState(() {
                widget._selectColor = color!;
              })
            },
            circleSize: 48.h,
            colors: WanThemes.themeColors,
          ),

          ///取消
          Row(
            children: [
              const Expanded(child: SizedBox()),
              TextButton(
                onPressed: () {
                  extDismissDialog();
                  setState(() {
                    widget._selectColor = extCurrentTheme().primaryColor;
                  });
                  widget.onCancel();
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
                  extDismissDialog();
                  widget.onComfrim(
                    widget._selectColor,
                  );
                },
                child: Text(
                  "确认",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: extUseColorWithDarkMod(
                      targetColor: widget._selectColor,
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


  ColorSwatch _getMaterialColor(Color primaryColor) {
    for (int i = 0; i < materialColors.length; i++) {
      if (materialColors[i].value == primaryColor.value) {
        return materialColors[i];
      }
    }
    return materialColors[0];
  }
}
