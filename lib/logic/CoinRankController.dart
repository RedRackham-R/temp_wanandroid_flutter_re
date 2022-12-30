import 'package:wanandroid_flutter_re/base/logic/BaseListController.dart';
import 'package:wanandroid_flutter_re/base/logic/state/ListDataUIState.dart';
import 'package:wanandroid_flutter_re/entity/user_coin_entity.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_list_entity.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/generated/json/base/json_convert_content.dart';
import 'package:wanandroid_flutter_re/model/CoinRankModel.dart';

class CoinRankController
    extends BaseListController<UserCoinEntity, CoinRankModel> {
  static const String tag = "CoinRankController";

  @override
  bool checkResult(result) {
    final WanCommonResultEntity realResult = result;
    return realResult.isSuccess();
  }

  @override
  List<UserCoinEntity> convertData(ListDataUIState state, result) {
    final WanCommonListEntity listEntity =
        (result as WanCommonResultEntity).data;
    List<UserCoinEntity>? datasList =
        jsonConvert.convertListNotNull<UserCoinEntity>(listEntity.datas);
    return datasList ?? [];
  }

  @override
  CoinRankModel creatModel() => CoinRankModel();

  @override
  bool hasMoreData(result) {
    final WanCommonListEntity entity = (result as WanCommonResultEntity).data;
    return entity.curPage! < entity.pageCount!;
  }

  @override
  String resultErrMsg(result) {
    final WanCommonResultEntity realResult = result;
    return realResult.errorMsg;
  }

  @override
  int get startingIndex => 1;
}
