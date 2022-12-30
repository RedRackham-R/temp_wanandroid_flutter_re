import 'package:wanandroid_flutter_re/base/logic/BaseDefaultController.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanDefaultModel.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';

abstract class BaseWanDefaultController<T>
    extends BaseDefaultController<T, BaseWanDefaultModel> {
  @override
  bool checkResult(result) {
    final realResult = result as WanCommonResultEntity;
    return realResult.isSuccess();
  }

  @override
  String resultErrMsg(result) {
    final realResult = result as WanCommonResultEntity;
    return realResult.errorMsg;
  }

}
