import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListModel.dart';
import 'package:wanandroid_flutter_re/net/WanService.dart';

class ProjectListModel extends BaseWanArticleListModel {
  String cid;

  ProjectListModel({
    required this.cid,
  });

  @override
  Future creatFetch(int index) =>
      WanService.fetchProjectArticle(cid: cid, index: index);
}
