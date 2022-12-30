import 'package:wanandroid_flutter_re/base_wan/BaseWanDefaultModel.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/net/WanService.dart';

///体系列表model
class SystemListModel extends BaseWanDefaultModel {
  @override
  Future<WanCommonResultEntity> creatFetch() => WanService.fetchSystemTag();
}
