import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_animations/simple_animations.dart';

/**
 * 显示logo以及文字
 */
class AnimatedLogoWeight extends StatelessWidget {
  const AnimatedLogoWeight({Key? key, required this.seconds}) : super(key: key);

  final int seconds;

  @override
  Widget build(BuildContext context) {
    var tween = Tween(begin: 0.0, end: 1.0);
    var duration = Duration(seconds: seconds);
    return LayoutBuilder(builder: (context, constraints) {
      return PlayAnimationBuilder(
          tween: tween,
          duration: duration,
          builder: (context, value, child) {
            return Container(
              alignment: AlignmentDirectional.center,
              child: Opacity(
                opacity: value as double,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const FlutterLogo(size: 180),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      "Wanandroid :)",
                      style: TextStyle(
                          fontSize: 38.sp,
                          color: Colors.white,
                          decoration: TextDecoration.none),
                    )
                  ],
                ),
              ),
            );
          });
    });
  }
}
