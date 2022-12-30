import 'package:wanandroid_flutter_re/base/logic/state/DataUIState.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanDefaultController.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanDefaultModel.dart';
import 'package:wanandroid_flutter_re/entity/tab_tag_entity.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/model/SystemListModel.dart';

class SystemListController
    extends BaseWanDefaultController<List<TabTagEntity>> {
  static const String tag = "SystemListController";

  double listOffset = 0;

  @override
  List<TabTagEntity>? convertData(DataUIState state, result) {
    final realResult = result as WanCommonResultEntity;
    return realResult.data as List<TabTagEntity>;
  }

  @override
  BaseWanDefaultModel creatModel() => SystemListModel();
}
