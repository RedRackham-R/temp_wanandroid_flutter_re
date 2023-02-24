import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid_flutter_re/entity/tab_tag_entity.dart';
import 'package:wanandroid_flutter_re/global/ext/ThemeExt.dart';

class TutorialItem extends StatelessWidget {
  final TabTagChildren data;
  final Function(TabTagChildren data) onTap;

  const TutorialItem({
    super.key,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.h),
      height: 180.h,
      alignment: Alignment.center,
      child: Row(
        children: [
          Image.network(
            data.cover!,
            loadingBuilder: (
              BuildContext context,
              Widget child,
              ImageChunkEvent? loadingProgress,
            ) {
              if (loadingProgress == null) {
                return child;
              } else {
                return const Icon(
                  Icons.image,
                  color: Colors.grey,
                );
              }
            },
            errorBuilder: (
              BuildContext context,
              Object error,
              StackTrace? stackTrace,
            ) {
              return const Icon(
                Icons.broken_image,
              );
            },
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name!,
                  maxLines: 1,
                  softWrap: true,
                  style: TextStyle(
                    color: extUseColorWithDarkMod(
                      targetColor: Colors.black,
                    ),
                    fontSize: 16.sp,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  data.desc!,
                  maxLines: 9,
                  softWrap: true,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
