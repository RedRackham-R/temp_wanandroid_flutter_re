import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListPage.dart';
import 'package:wanandroid_flutter_re/logic/SearchResultController.dart';

class SearchResultPage extends StatefulWidget {
  static SearchResultPage newInstance({required String keyword}) {
    if (Get.isRegistered<SearchResultController>(
        tag: SearchResultController.tag)) {
      final controller  = Get.find<SearchResultController>(tag: SearchResultController.tag);
      controller.updateKeyword = keyword;
    } else {
      Get.put(
        SearchResultController(keyword),
        tag: SearchResultController.tag,
      );
    }

    return SearchResultPage();
  }

  @override
  State<StatefulWidget> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      _ResultList(tag: SearchResultController.tag);
}

class _ResultList extends BaseWanArticleListPage<SearchResultController> {
  _ResultList({required super.tag});

  @override
  bool get useControlBnv => false;
}
