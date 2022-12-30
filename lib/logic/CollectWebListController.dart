import 'package:wanandroid_flutter_re/base/logic/BaseListController.dart';
import 'package:wanandroid_flutter_re/base/logic/state/ListDataUIState.dart';
import 'package:wanandroid_flutter_re/base/logic/state/LoadingState.dart';
import 'package:wanandroid_flutter_re/entity/collect_web_entity.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/global/Constant.dart';
import 'package:wanandroid_flutter_re/main.dart';
import 'package:wanandroid_flutter_re/model/CollectWebListModel.dart';

class CollectWebListController
    extends BaseListController<CollectWebEntity, CollectWebListModel> {
  static const tag = "CollectWebListController";

  ///增加收藏web事件的监听，如果是取消收藏的事件，则把对应取消文章id的数据删除
  late Function() _uncollectWebListener;

  @override
  void onInit() {
    super.onInit();
    _uncollectWebListener = () {
      if (globalCollectController.collectWebState.isCollect == false) {
        final targetId = globalCollectController.collectWebState.id;
        int unCollectIndex = -1;
        for (int i = 0; i < data.length; i++) {
          if (data[i].id == targetId) {
            unCollectIndex = i;
            break;
          }
        }
        if (unCollectIndex != -1) {
          dataState.listData.removeAt(unCollectIndex);
          if (dataState.listData.isEmpty) {
            updateLoadingState = LoadingState(type: LoadStateType.EMPTY);
          } else {
            updateDataState = dataState;
          }
        }
      }
    };

    globalCollectController.subscribe(
        key: Constant.GLOBAL_COLLECT_WEB, listener: _uncollectWebListener);
  }

  @override
  void dispose() {
    super.dispose();
    globalCollectController.unSubscribe(
        key: Constant.GLOBAL_COLLECT_WEB, listener: _uncollectWebListener);
  }

  @override
  bool checkResult(result) {
    final WanCommonResultEntity realResult = result as WanCommonResultEntity;
    return realResult.isSuccess();
  }

  @override
  List<CollectWebEntity> convertData(ListDataUIState state, result) {
    final WanCommonResultEntity realResult = result;
    List<CollectWebEntity?> data = realResult.data;
    List<CollectWebEntity> realData = [];
    for (var element in data) {
      realData.add(element!);
    }
    return realData;
  }

  @override
  CollectWebListModel creatModel() => CollectWebListModel();

  @override
  bool hasMoreData(result) => false;

  @override
  String resultErrMsg(result) {
    final WanCommonResultEntity realResult = result as WanCommonResultEntity;
    return realResult.errorMsg;
  }
}
