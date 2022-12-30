import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListPage.dart';
import 'package:wanandroid_flutter_re/entity/banner_entity.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/logic/HomeController.dart';
import 'package:wanandroid_flutter_re/ui/weight/items/ArticleBanner.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeList(),
    );
  }
}

class _HomeList extends BaseWanArticleListPage<HomeController> {
  _HomeList() : super(tag: HomeController.tag);

  @override
  List<Widget>? headers() {
    final banners = <BannerEntity>[];
    for (var element in controller.extraData1) {
      banners.add(element as BannerEntity);
    }
    return <Widget>[
      EasyRefresh(
        controller: EasyRefreshController(
          controlFinishRefresh: false,
          controlFinishLoad: false,
        ),
        child: ArticleBanner(
          data: banners,
          onItemTap: (BannerEntity item) {
            extShowToast("点击了${item.title!}");
          },
        ),
      ),
    ];
  }
}
