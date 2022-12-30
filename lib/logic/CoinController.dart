import 'package:wanandroid_flutter_re/base/logic/BaseListController.dart';
import 'package:wanandroid_flutter_re/base/logic/state/ListDataUIState.dart';
import 'package:wanandroid_flutter_re/entity/coin_list_entity.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_list_entity.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/generated/json/base/json_convert_content.dart';
import 'package:wanandroid_flutter_re/global/Constant.dart';
import 'package:wanandroid_flutter_re/model/CoinModel.dart';

class CoinController extends BaseListController<CoinListDatas, CoinModel> {
  static const String tag = "CoinController";

  bool _isShowCoinTitle = false;

  bool get isShowCoinTitle => _isShowCoinTitle;

  set updateShowTitle(bool isShow) => {
        _isShowCoinTitle = isShow,
        update([Constant.COIN_SHOW_TITLE])
      };

  @override
  bool checkResult(result) {
    final WanCommonResultEntity realResult = result;
    return realResult.isSuccess();
  }

  @override
  List<CoinListDatas> convertData(ListDataUIState state, result) {
    final WanCommonListEntity listEntity =
        (result as WanCommonResultEntity).data;
    List<CoinListDatas>? datasList =
        jsonConvert.convertListNotNull<CoinListDatas>(listEntity.datas);
    return datasList ?? [];
  }

  @override
  CoinModel creatModel() => CoinModel();

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
