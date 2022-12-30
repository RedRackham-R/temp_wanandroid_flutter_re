import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/global/Constant.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/global/ext/DialogExt.dart';
import 'package:wanandroid_flutter_re/global/ext/ThemeExt.dart';
import 'package:wanandroid_flutter_re/logic/SearchTagController.dart';

import 'package:wanandroid_flutter_re/utils/ColorUtils.dart';

class SearchTagPage extends GetView<SearchTagController> {
  Function(String tag) onClick;

  static newInstance({required Function(String tag) onClick}) {
    Get.lazyPut(() => SearchTagController(), fenix: true);
    return SearchTagPage(
      onClick: onClick,
    );
  }

  SearchTagPage({Key? key, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.fetchLocalKeywords();
    return Container(
      color: extCurrentTheme().cardColor,
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 12.h,
            left: 8.w,
            right: 8.w,
            bottom: 12.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<SearchTagController>(
                id: Constant.SEARCH_TAG_HOT_KEYWORDS,
                init: controller,
                builder: (SearchTagController controller) {
                  return controller.hotKeywords.isNullOrEmpty()
                      ? const SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "大家都在搜：",
                              style: TextStyle(
                                color: extUseColorWithDarkMod(
                                  targetColor: extCurrentTheme().primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Wrap(
                              ///内部控件对其
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 18.w,
                              runSpacing: 12.h,
                              alignment: WrapAlignment.start,
                              children: _creatHotKeywordsTagItem(),
                            ),
                          ],
                        );
                },
              ),
              GetBuilder<SearchTagController>(
                id: Constant.SEARCH_TAG_HISTORY_KEYWORDS,
                init: controller,
                builder: (SearchTagController controller) {
                  return controller.localKeywords.isNullOrEmpty()
                      ? const SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "历史搜索：",
                                  style: TextStyle(
                                    color: extUseColorWithDarkMod(
                                      targetColor:
                                          extCurrentTheme().primaryColor,
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: Colors.grey,
                                    size: 20.w,
                                  ),
                                  onPressed: () {
                                    extShowComfrimDialog(
                                      title: "确认",
                                      content: "清除历史记录？",
                                      barrierDismissible: true,
                                      cancel: () {},
                                      onConfirm: () {
                                        controller.clearHistory();
                                        extDismissDialog();
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            Wrap(
                              ///内部控件对其
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 18.w,
                              runSpacing: 12.h,
                              alignment: WrapAlignment.start,
                              children: _creatHistoryItem(),
                            ),
                          ],
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _creatHistoryItem() {
    final items = <Widget>[];
    for (var element in controller.localKeywords) {
      items.add(GestureDetector(
        onTap: () {
          onClick(element);
        },
        child: Text(
          element,
          style: TextStyle(
            color: extUseColorWithDarkMod(
              targetColor: Colors.grey.shade600,
              darkModColor: Colors.grey.shade400,
            ),
          ),
        ),
      ));
    }

    return items;
  }

  List<Widget> _creatHotKeywordsTagItem() {
    final items = <Widget>[];
    for (var element in controller.hotKeywords) {
      items.add(GestureDetector(
        onTap: () {
          onClick(element!.name);
        },
        child: Text(
          element!.name,
          style: TextStyle(
            color: extUseColorWithDarkMod(
              targetColor: ColorUtils.creatRadomColor(),
              darkModColor: extCurrentTheme().textTheme.bodyText1!.color,
            ),
          ),
        ),
      ));
    }
    return items;
  }
}
