import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanDefualtPage.dart';
import 'package:wanandroid_flutter_re/logic/WechatController.dart';
import 'package:wanandroid_flutter_re/logic/WechatListController.dart';
import 'package:wanandroid_flutter_re/ui/pages/wechat/WechatListPage.dart';
import 'package:wanandroid_flutter_re/ui/weight/TabContainer.dart';

class WechatPage extends StatelessWidget {
  const WechatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => _WechatList();
}

class _WechatList extends BaseWanDefaultPage<WechatController> {
  _WechatList() : super(tag: WechatController.tag);

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
          return _creatWechatList(tab.id!);
        },
      ).toList(),
      onPageChange: (index) {
        controller.curIndex = index;
      },
    );
  }

  Widget _creatWechatList(int cid) {
    Widget? page = controller.getPageCache(cid);
    if (page == null) {
      Get.lazyPut(() => WechatListController(cid: cid.toString()),
          tag: cid.toString());
      page = WechatListPage(
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
