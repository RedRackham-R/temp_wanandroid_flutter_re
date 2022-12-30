import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/logic/SystemListController.dart';
import 'package:wanandroid_flutter_re/ui/pages/system/NavPage.dart';
import 'package:wanandroid_flutter_re/ui/pages/system/SystemListPage.dart';
import 'package:wanandroid_flutter_re/ui/weight/TabContainer.dart';

class SystemPage extends StatelessWidget {
  final pages = <Widget>[];
  final titles = <String>["体系", "导航"];
  int _curIndex = 0;

  SystemPage({Key? key}) : super(key: key) {
    _initPages();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarContainer(
      //设置不可滚动，所有tab平分屏幕宽度
      scrollable: false,
      lenth: 2,
      tabs: titles.map((tab) => Tab(text: tab)).toList(),
      tabBarViewChildren: pages,
      onPageChange: (index) {
        _curIndex = index;
      },
      initIndex: _curIndex,
    );
  }

  _initPages() {
    Get.put(
      SystemListController(),
      tag: SystemListController.tag,
    );
    pages.add(SystemListPage());
    pages.add(NavPage());
  }
}
