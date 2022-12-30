import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum AniProps { color1, color2 }

class AnimatedBackgroundWeight extends StatelessWidget {
  const AnimatedBackgroundWeight({
    required this.color1Start,
    required this.color1End,
    required this.color2Start,
    required this.color2End,
    required this.duration,
    Key? key,
  }) : super(key: key);

  final Color color1Start;
  final Color color1End;

  final Color color2Start;
  final Color color2End;

  final Duration duration;

  @override
  Widget build(BuildContext context) {
    var moviTween = MovieTween();
    moviTween
        .scene(duration: duration)
        .tween("color1", ColorTween(begin: color1Start, end: color1End))
        .tween("color2", ColorTween(begin: color2Start, end: color2End));

    return MirrorAnimationBuilder<Movie>(
        //使用MirrorAnimation 1-0-1的顺序播放动画
        tween: moviTween,
        duration: moviTween.duration,
        builder: (context, value, child) {
          return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [value.get("color1"), value.get("color2")])));
        },
        curve: Curves.easeInOut);
  }
}
