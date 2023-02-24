import 'package:flutter/material.dart';
import 'package:wanandroid_flutter_re/base/page/BaseListPage.dart';
import 'package:wanandroid_flutter_re/entity/tab_tag_entity.dart';
import 'package:wanandroid_flutter_re/logic/TutorialListController.dart';
import 'package:wanandroid_flutter_re/ui/weight/items/TutorialItem.dart';

class TutorialListPage extends StatelessWidget {
  const TutorialListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //去掉阴影
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: const Text(
          "实用教程",
        ),
      ),
      body: _TutorialListPage(),
    );
  }
}

class _TutorialListPage extends BaseListPage<TutorialListController> {
  _TutorialListPage() : super(tag: TutorialListController.tag);

  @override
  Widget creatItem(BuildContext context, int index) => TutorialItem(
        data: controller.data[index],
        onTap: (TabTagChildren data) {

        },
      );
}
