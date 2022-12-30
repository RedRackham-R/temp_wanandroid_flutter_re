import 'package:wanandroid_flutter_re/base_wan/BaseWanDefaultModel.dart';
import 'package:wanandroid_flutter_re/net/WanService.dart';

class ProjectModel extends BaseWanDefaultModel {
  @override
  Future creatFetch() => WanService.fetchProjectTag();
}
