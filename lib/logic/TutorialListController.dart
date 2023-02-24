import 'package:wanandroid_flutter_re/base/logic/BaseListController.dart';
import 'package:wanandroid_flutter_re/base/logic/state/ListDataUIState.dart';
import 'package:wanandroid_flutter_re/entity/tab_tag_entity.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/model/TutorialListModel.dart';

class TutorialListController
    extends BaseListController<TabTagChildren, TutorialListModel> {
  static const String tag = "TutorialListController";

  @override
  bool checkResult(result) {
    WanCommonResultEntity realResult = result as WanCommonResultEntity;
    return realResult.isSuccess();
  }

  @override
  List<TabTagChildren> convertData(ListDataUIState state, result) {
    final realResult = result as WanCommonResultEntity;
    return realResult.data as List<TabTagChildren>;
  }

  @override
  TutorialListModel creatModel() => TutorialListModel();

  @override
  bool hasMoreData(result) => false;

  @override
  String resultErrMsg(result) {
    WanCommonResultEntity realResult = result as WanCommonResultEntity;
    return realResult.errorMsg;
  }
}
