import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListModel.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/net/WanService.dart';

class ShareArticleModel extends BaseWanArticleListModel {
  @override
  Future creatFetch(int index) => WanService.fetchPrivateArticles(index: index);

  ///删除分享
  Future<WanCommonResultEntity> fetchDeleteShareArticle({
    required int id,
  }) =>
      WanService.fetchDeleteShareArticle(id: id);
}
