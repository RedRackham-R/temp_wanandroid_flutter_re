import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/logic/SearchController.dart';
import 'package:wanandroid_flutter_re/main.dart';

import 'package:wanandroid_flutter_re/ui/pages/search/SearchResultPage.dart';
import 'package:wanandroid_flutter_re/ui/pages/search/SearchTagPage.dart';

class SearchPage extends GetView<SearchController> {
  late TextEditingController _editController;

  final FocusNode _edtFocusNode = FocusNode();

  SearchPage({Key? key}) : super(key: key) {
    _editController = TextEditingController();
    _editController.addListener(() {
      if (_editController.text.isEmpty && controller.curPage == 1) {
        controller.toTag();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onBack();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: TextField(
            focusNode: _edtFocusNode,
            controller: _editController,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: extCurrentTheme().primaryTextTheme.bodyText1!.color,
            ),
            textAlign: TextAlign.start,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "使用空格分隔多个关键字",
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: extCurrentTheme().primaryTextTheme.headline1!.color,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  50.h,
                ),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              contentPadding: EdgeInsets.only(
                top: 8.h,
                bottom: 8.h,
                left: 12.w,
                right: 12.w,
              ),
              fillColor: Colors.white24,
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.close,
                ),
                color: extCurrentTheme().primaryTextTheme.bodyText1!.color,
                onPressed: () {
                  _editController.clear();
                },
              ),
              isCollapsed: true,
            ),
            cursorColor: extCurrentTheme().primaryTextTheme.headline1!.color,
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
              ),
              onPressed: () {
                extUnfocusHideKeyboard();
                controller.toSearch(_editController.text);
              },
            ),
          ],
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              _onBack();
            },
          ),
        ),
        body: GetBuilder<SearchController>(
          init: controller,
          id: "updatePage",
          builder: (SearchController controller) {
            final page;
            if (controller.curPage == 0) {
              _edtFocusNode.requestFocus();
              page = SearchTagPage.newInstance(
                onClick: (String keywords) {
                  globalAppController.addHistoryKeyword(keywords: keywords);
                  _editController.text = keywords;
                  controller.toSearch(keywords);
                },
              );
            } else {
              extUnfocusHideKeyboard();
              page =
                  SearchResultPage.newInstance(keyword: _editController.text);
            }
            return page;
          },
        ),
      ),
    );
  }

  _onBack() {
    if (controller.curPage == 1) {
      _editController.clear();
    } else {
      Get.back();
    }
  }
}
