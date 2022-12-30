import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/net/WanService.dart';

class GlobalAppModel {
  Future<WanCommonResultEntity> netFetchUserCoinInfo() =>
      WanService.fetchUserCoinInfo();
}
