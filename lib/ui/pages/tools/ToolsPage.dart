import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/base/page/BaseListPage.dart';
import 'package:wanandroid_flutter_re/entity/tool_entity.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/global/ext/ThemeExt.dart';
import 'package:wanandroid_flutter_re/logic/ToolsController.dart';


class ToolsPage extends StatelessWidget {
  const ToolsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //去掉阴影
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: const Text(
          "工具箱",
        ),
      ),
      body: _ToosList(tag: ToolsController.tag),
    );
  }
}

class _ToosList extends BaseListPage<ToolsController> {
  _ToosList({required super.tag});

  @override
  Widget creatItem(BuildContext context, int index) =>
      _buildToolItem(controller.data[index]);

  Widget _buildToolItem(ToolEntity item) {
    return InkWell(
      onTap: () {
        extShowToast("打开工具：${item.name}");
      },
      child: Card(
        child: Row(
          children: [
            Image.network(
              "https://www.wanandroid.com/resources/image/pc/tools/${item.icon!}",
              height: 38.h,
              width: 38.h,
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
              width: 20.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  item.name!,
                  style: TextStyle(
                    color: extUseColorWithDarkMod(
                      targetColor: extCurrentTheme().primaryColor,
                    ),
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  item.name!,
                  style: TextStyle(
                    color: extCurrentTheme().textTheme.headline1!.color!,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
