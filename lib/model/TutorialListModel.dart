import 'package:wanandroid_flutter_re/base/model/BaseDefaultModel.dart';
import 'package:wanandroid_flutter_re/base/model/BaseListModel.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanDefaultModel.dart';
import 'package:wanandroid_flutter_re/net/WanService.dart';

class TutorialListModel extends BaseListModel {
  @override
  Future creatFetch(int index) => WanService.fetchTutorialList();
}
