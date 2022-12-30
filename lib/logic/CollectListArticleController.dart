import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/base/logic/state/ListDataUIState.dart';
import 'package:wanandroid_flutter_re/base/logic/state/LoadingState.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListController.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListModel.dart';
import 'package:wanandroid_flutter_re/entity/article_entity.dart';
import 'package:wanandroid_flutter_re/entity/article_list_entity.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/global/Constant.dart';
import 'package:wanandroid_flutter_re/main.dart';
import 'package:wanandroid_flutter_re/model/CollectArticleListModel.dart';

///收藏文章列表
class CollectArticleListController extends BaseWanArticleListController {
  static const tag = "CollectArticleListController";

  ///增加收藏事件的监听，如果是取消收藏的事件，则把对应取消文章id的数据删除
  late Function() _handleUncollectListener;

  @override
  void onInit() {
    super.onInit();
    _handleUncollectListener = () {
      if (globalCollectController.collectArticleState.isCollect == false) {
        final targetId = globalCollectController.collectArticleState.id;
        int unCollectIndex = -1;
        for (int i = 0; i < data.length; i++) {
          if (data[i].originId == targetId) {
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
        key: Constant.GLOBAL_COLLECT_ARTICLE,
        listener: _handleUncollectListener);
  }

  @override
  void dispose() {
    super.dispose();
    globalCollectController.unSubscribe(
        key: Constant.GLOBAL_COLLECT_ARTICLE,
        listener: _handleUncollectListener);
  }

  @override
  BaseWanArticleListModel creatModel() => CollectArticListleModel();

  ///这里需要转换一下，因为获取文章收藏列表数据没有collect参数 这里自己补上
  @override
  List<ArticleEntity> convertData(ListDataUIState state, result) {
    final WanCommonResultEntity realResult = result;
    final ArticleListEntity entity = realResult.data;
    final List<ArticleEntity>? datas = entity.datas;
    datas?.forEach((element) {
      element.collect = true;
    });
    if (datas.isNullOrEmpty()) {
      return [];
    } else {
      return datas!;
    }
  }
}
