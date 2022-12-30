import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListModel.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/main.dart';
import 'package:wanandroid_flutter_re/net/WanService.dart';

class HomeModel extends BaseWanArticleListModel {
  @override
  Future creatFetch(int index) {
    final fetchlist = <Future<WanCommonResultEntity>>[];
    //文章列表
    fetchlist.add(WanService.fetchArticleList(index: index));

    //banner
    if (index == 0) {
      fetchlist.add(WanService.fetchBanner());
    }

    if (index == 0 && globalAppController.settings.showTopActicle) {
      //置顶广告文章
      fetchlist.add(WanService.fetchArticleTop());
    }
    return Future.wait(fetchlist);
  }
}
