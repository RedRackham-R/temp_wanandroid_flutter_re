import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid_flutter_re/entity/banner_entity.dart';


class ArticleBanner extends StatelessWidget {
  final List<BannerEntity> data;
  final Function(BannerEntity item) onItemTap;

  const ArticleBanner({
    required this.data,
    required this.onItemTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: CarouselSlider(
        carouselController: CarouselController(),
        options: CarouselOptions(
          height: 210.h,
          viewportFraction: 1,
          enableInfiniteScroll: true,
          autoPlay: true,
        ),
        items: [
          for (int i = 0; i < data.length; i++)
            GestureDetector(
              onTap: () {
                onItemTap(data[i]);
              },
              child: Image.network(
                data[i].imagePath!,
                fit: BoxFit.fill,
              ),
            ),
        ],
      ),
    );
  }
}
