import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/main.dart';

class SearchController extends GetxController {
  ///当前页面 0 tag页 1搜索结果页
  int _curPage = 0;

  int get curPage => _curPage;

  set updatePage(int page) {
    _curPage = page;
    update(["updatePage"]);
  }

  ///到搜索结果页面
  toSearch(String? keyword) {
    if (keyword.isNullOrEmpty()) {
      return;
    }
    globalAppController.addHistoryKeyword(keywords: keyword!);
    updatePage = 1;
  }

  ///到tag页面
  toTag() {
    if (_curPage != 0) {
      updatePage = 0;
    }
  }
}
