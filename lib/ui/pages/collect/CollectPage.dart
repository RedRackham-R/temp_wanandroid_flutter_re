import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/logic/CollectListArticleController.dart';
import 'package:wanandroid_flutter_re/logic/CollectWebListController.dart';

import 'package:wanandroid_flutter_re/ui/pages/collect/CollectArticlListePage.dart';
import 'package:wanandroid_flutter_re/ui/pages/collect/CollectWebListPage.dart';

/// 收藏页面
class CollectPage extends StatelessWidget {
  static CollectPage newInstance() {
    return CollectPage();
  }

  final titles = <String>["文章", "网址"];
  final pages = <Widget>[];

  CollectPage({Key? key}) : super(key: key) {
    _initPages();
  }

  _initPages() {
    //收藏文章列表
    Get.lazyPut(
      () => CollectArticleListController(),
      tag: CollectArticleListController.tag,
    );
    pages.add(const CollectArticlListePage());

    //收藏网页列表
    Get.lazyPut(
      () => CollectWebListController(),
      tag: CollectWebListController.tag,
    );
    pages.add(const CollectWebListPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //去掉阴影
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: const Text(
          "我的收藏",
        ),
      ),
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Column(
          children: [
            Container(
              color: extCurrentTheme().primaryColor,
              child: TabBar(
                isScrollable: false, //设置不可滚动，所有tab平分屏幕宽度
                tabs: titles
                    .map(
                      (title) => Tab(
                        text: title,
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: pages,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
