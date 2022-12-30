import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListModel.dart';
import 'package:wanandroid_flutter_re/net/WanService.dart';

class SquareModel extends BaseWanArticleListModel {
  @override
  Future creatFetch(int index) => WanService.fetchUserArticle(index: index);
}
