import 'dart:math';

import 'package:flutter/material.dart';

class ColorUtils {
  ////0-190, 如果颜色值过大,就越接近白色,就看不清了,所以需要限定范围
  static Color creatRadomColor({
    int maxRed = 190,
    int maxGreen = 190,
    int maxBlue = 190,
  }) {
    final red = Random().nextInt(maxRed);
    final green = Random().nextInt(maxRed);
    final blue = Random().nextInt(maxRed);
    return Color.fromARGB(255, red, green, blue);
  }

  static Color transDeepColor({required Color color}) {
    var red = color.red;
    var green = color.green;
    var blue = color.blue;

    final rs, gs, bs;
    rs = red / 255;
    gs = green / 255;
    bs = blue / 255;

    red = red ~/ 3;
    green = green ~/ 3;
    blue = blue ~/ 3;
    return Color.fromARGB(color.alpha, red, green, blue);
  }
}
