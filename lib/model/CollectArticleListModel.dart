import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListModel.dart';
import 'package:wanandroid_flutter_re/net/WanService.dart';

class CollectArticListleModel extends BaseWanArticleListModel {
  @override
  Future creatFetch(int index) =>
      WanService.fetchCollectArticleList(index: index);
}
