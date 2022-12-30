import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid_flutter_re/base/page/BaseListPage.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/global/ext/ThemeExt.dart';
import 'package:wanandroid_flutter_re/logic/CollectWebListController.dart';
import 'package:wanandroid_flutter_re/main.dart';

import 'package:wanandroid_flutter_re/ui/weight/TapLoadingWidget.dart';

class CollectWebListPage extends StatelessWidget {
  const CollectWebListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      _CollectedWebList(tag: CollectWebListController.tag);
}

class _CollectedWebList extends BaseListPage<CollectWebListController> {
  _CollectedWebList({required super.tag});

  @override
  Widget creatItem(BuildContext context, int index) {
    return _buildItem(context, index);
  }

  Widget _buildItem(BuildContext context, int index) {
    return Card(
      margin: EdgeInsets.all(
        8.w,
      ),
      child: Padding(
        padding: EdgeInsets.all(
          8.w,
        ),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        maxLines: 1,
                        controller.data[index].name.toString(),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Expanded(
                      child: Text(
                        controller.data[index].link.toString(),
                        maxLines: 1,
                        style: TextStyle(
                          color: extUseColorWithDarkMod(
                            targetColor: extCurrentTheme().primaryColor,
                          ),
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            TapLoadingWidget(
              size: extCurrentTheme().iconTheme.size!,
              defaultWidget: Icon(
                Icons.delete_forever,
                color: Colors.red.shade700,
              ),
              onPress: () {
                globalCollectController.unCollectWeb(
                    id: controller.data[index].id!);
              },
              loading: controller.data[index].extIsLoading,
            ),
          ],
        ),
      ),
    );
  }
}
