import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListPage.dart';
import 'package:wanandroid_flutter_re/global/ext/DialogExt.dart';
import 'package:wanandroid_flutter_re/logic/ShareArticleController.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wanandroid_flutter_re/routes/routes_config.dart';

///分享页面
class SharePage extends StatelessWidget {
  const SharePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //去掉阴影
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: const Text(
          "我的分享",
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
            ),
            onPressed: () async {
              final result = await Get.toNamed(RoutesConfig.SHARE_EDIT);
              if (result == true) {
                Get.find<ShareArticleController>(
                  tag: ShareArticleController.tag,
                ).reloadPrivateArticle();
              }
            },
          ),
        ],
      ),
      body: _ShareList(tag: ShareArticleController.tag),
    );
  }
}

class _ShareList extends BaseWanArticleListPage<ShareArticleController> {
  _ShareList({required super.tag});

  @override
  Widget creatList() {
    return SlidableAutoCloseBehavior(
      child: ListView.builder(
        itemCount: controller.data.length,
        controller: ScrollController(),
        itemBuilder: (BuildContext context, int index) {
          return creatItem(context, index);
        },
      ),
    );
  }

  @override
  Widget creatItem(BuildContext context, int index) {
    final Widget articleItem = super.creatItem(context, index);
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: '编辑',
            onPressed: (BuildContext context) async {
              ///编辑就带article过去
              final result = await Get.toNamed(
                RoutesConfig.SHARE_EDIT,
                arguments: controller.data[index],
              );

              if (result == true) {
                controller.reloadPrivateArticle();
              }
            },
          ),
        ],
      ),
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const BehindMotion(),
        children: [
          //侧滑按钮
          SlidableAction(
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: '删除',
            onPressed: (BuildContext context) {
              extShowComfrimDialog(
                title: "确认",
                content:
                    "是否删除该文章：\n\n【${controller.data[index].title!}】\n\n${controller.data[index].link!}",
                onConfirm: () {
                  extDismissDialog();
                  controller.deleteShareArticle(id: controller.data[index].id!);
                },
                cancel: () {},
              );
            },
          ),
        ],
      ),
      child: articleItem,
    );
  }
}
