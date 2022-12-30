import 'package:flutter/material.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListPage.dart';
import 'package:wanandroid_flutter_re/logic/CollectListArticleController.dart';

class CollectArticlListePage extends StatelessWidget {
  const CollectArticlListePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      _CollectArticleList(tag: CollectArticleListController.tag);
}

class _CollectArticleList
    extends BaseWanArticleListPage<CollectArticleListController> {
  _CollectArticleList({required super.tag});
}
