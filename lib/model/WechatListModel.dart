import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListModel.dart';
import 'package:wanandroid_flutter_re/net/WanService.dart';

class WechatListModel extends BaseWanArticleListModel {
  String cid;

  WechatListModel({
    required this.cid,
  });

  @override
  Future creatFetch(int index) =>
      WanService.fetchWechatArticle(cid: cid, index: index);
}
