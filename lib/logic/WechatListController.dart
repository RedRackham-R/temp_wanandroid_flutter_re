import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListController.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListModel.dart';
import 'package:wanandroid_flutter_re/model/WechatListModel.dart';

class WechatListController extends BaseWanArticleListController {
  String cid;

  WechatListController({
    required this.cid,
  });

  @override
  BaseWanArticleListModel creatModel() => WechatListModel(cid: cid);

  @override
  int get startingIndex => 1;
}
