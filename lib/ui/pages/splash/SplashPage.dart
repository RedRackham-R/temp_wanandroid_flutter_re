import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/routes/routes_config.dart';
import 'package:wanandroid_flutter_re/ui/weight/AnimatedBackgroundWeight.dart';
import 'package:wanandroid_flutter_re/ui/weight/AnimatedLogoWeight.dart';
import 'package:wanandroid_flutter_re/ui/weight/AnimatedWaveWeight.dart';

enum AniProps { color1, color2 }

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashStatus();
  }
}

class _SplashStatus extends State<SplashPage> {
  int _countdown = 5;
  var _timer;
  var skipText = "进入";

  @override
  void initState() {
    super.initState();
    // _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: AnimatedBackgroundWeight(
            color1Start: Colors.blue.shade900,
            color2Start: Colors.green.shade900,
            color1End: Colors.blue.shade900,
            color2End: Colors.purple.shade900,

            //渐变背景
            // color1Start: Colors.orange.shade900,
            // color2Start: Colors.deepPurple.shade900,
            // color1End: Colors.blue.shade900,
            // color2End: Colors.lightBlue.shade400,
            duration: const Duration(seconds: 3),
          ),
        ),
        onBottom(const AnimatedWaveWeight(height: 280, speed: 1.0)),
        onBottom(
          const AnimatedWaveWeight(height: 250, speed: 0.9, offset: pi),
        ),
        onBottom(
          const AnimatedWaveWeight(height: 240, speed: 1.2, offset: pi / 2),
        ),
        onCenter(const AnimatedLogoWeight(seconds: 5)),
        Positioned(
          bottom: 120.h,
          right: 48.w,
          left: 48.w,
          child: OutlinedButton(
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                const BorderSide(
                  width: 0.8,
                  color: Colors.white,
                  style: BorderStyle.solid,
                ),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            onPressed: () {
              _toIndexPage();
            },
            child: Text(
              skipText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
        // Positioned(
        //   right: 0,
        //   child: SafeArea(
        //     //使用SafeArea 让控件保持在状态栏之下
        //     child: OutlinedButton(
        //       style: ButtonStyle(
        //         side: MaterialStateProperty.all(const BorderSide(
        //           width: 0.8,
        //           color: Colors.white,
        //           style: BorderStyle.solid,
        //         )),
        //         shape: MaterialStateProperty.all(RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(30.0),
        //         )),
        //       ),
        //       onPressed: () {
        //         print('onPress');
        //         _jump2Main();
        //       },
        //       child: Text(
        //         skipText,
        //         style: const TextStyle(color: Colors.white),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  onTopRight(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.topRight,
          child: child,
        ),
      );

  onCenter(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      );

  onBottom(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      );

  // 启动Timer
  void _startTimer() {
    const Duration duration = Duration(seconds: 1);
    _timer = Timer.periodic(duration, (timer) {
      _countdown = _countdown - 1;

      print('CountValue');
      print(_countdown);
      if (_countdown <= 0) {
        skipText = "跳过";
        setState(() {});
        _cancelTimer();
      } else {
        skipText = _countdown.toString();
        setState(() {});
      }
    });
  }

  void _cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  /// 跳转到IndexPage
  _toIndexPage() {

    Get.offNamed(
      RoutesConfig.INDEX,
    );
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }
}
