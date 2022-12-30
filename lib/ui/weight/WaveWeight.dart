import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid_flutter_re/ui/weight/AnimatedBackgroundWeight.dart';
import 'package:wanandroid_flutter_re/ui/weight/AnimatedLogoWeight.dart';
import 'package:wanandroid_flutter_re/ui/weight/AnimatedWaveWeight.dart';

class WaveWeight extends StatefulWidget {
  Widget? child;

  WaveWeight({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WaveStatus();
  }
}

class _WaveStatus extends State<WaveWeight> {
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
        Positioned.fill(
          child: SafeArea(child: widget.child ?? const SizedBox()),
        ),
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

  @override
  void dispose() {
    super.dispose();
  }
}
