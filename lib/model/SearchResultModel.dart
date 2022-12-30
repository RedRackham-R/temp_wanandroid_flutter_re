import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListModel.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/net/WanService.dart';

class SearchResultModel extends BaseWanArticleListModel {
  String keyword;

  SearchResultModel(this.keyword);

  @override
  Future<WanCommonResultEntity> creatFetch(int index) =>
      WanService.fetchSearch(index: index, keywords: keyword);
}
