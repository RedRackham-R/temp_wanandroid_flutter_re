import 'package:wanandroid_flutter_re/base/logic/BaseListController.dart';
import 'package:wanandroid_flutter_re/base/logic/state/ListDataUIState.dart';
import 'package:wanandroid_flutter_re/entity/tool_entity.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/model/ToolsModel.dart';

class ToolsController extends BaseListController<ToolEntity, ToolsModel> {
  static const tag = "ToolsController";

  @override
  bool checkResult(result) {
    WanCommonResultEntity realResult = result as WanCommonResultEntity;
    return realResult.isSuccess();
  }

  @override
  List<ToolEntity> convertData(ListDataUIState state, result) {
    WanCommonResultEntity realResult = result as WanCommonResultEntity;
    List<ToolEntity?>? data = realResult.data;
    List<ToolEntity> realData = [];
    data?.forEach((element) {
      if (element != null) {
        realData.add(element);
      }
    });
    return realData;
  }

  @override
  ToolsModel creatModel() => ToolsModel();

  @override
  bool hasMoreData(result) => false;

  @override
  String resultErrMsg(result) {
    WanCommonResultEntity realResult = result as WanCommonResultEntity;
    return realResult.errorMsg;
  }
}
