import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanDefualtPage.dart';
import 'package:wanandroid_flutter_re/logic/ProjectController.dart';
import 'package:wanandroid_flutter_re/logic/ProjectListController.dart';
import 'package:wanandroid_flutter_re/ui/pages/project/ProjectListPage.dart';
import 'package:wanandroid_flutter_re/ui/weight/TabContainer.dart';

class ProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _ProjectListPage();
}

class _ProjectListPage extends BaseWanDefaultPage<ProjectController> {
  _ProjectListPage() : super(tag: ProjectController.tag);

  @override
  Widget successPage(BuildContext context) {
    return TabBarContainer(
      initIndex: controller.curIndex,
      lenth: controller.data!.length,
      tabs: controller.data!
          .map((tab) => Tab(text: "${tab.name}${tab.id}"))
          .toList(),
      tabBarViewChildren: controller.data!.map(
        (tab) {
          return _creatWechatListPage(tab.id!);
        },
      ).toList(),
      onPageChange: (index) {
        controller.curIndex = index;
      },
    );
  }

  Widget _creatWechatListPage(int cid) {
    Widget? page = controller.getPageCache(cid);
    if (page == null) {
      Get.lazyPut(() => ProjectListController(cid: cid.toString()),
          tag: cid.toString());
      page = ProjectListPage(
        tag: cid.toString(),
      );
      controller.updatePage(cid, page);
    }
    return page;
  }

  @override
  void onPress() {
    controller.loadData();
  }
}
