import 'package:wanandroid_flutter_re/base/model/BaseListModel.dart';
import 'package:wanandroid_flutter_re/net/WanService.dart';

class ToolsModel extends BaseListModel {
  @override
  Future creatFetch(int index) => WanService.fetchToolsList();
}
