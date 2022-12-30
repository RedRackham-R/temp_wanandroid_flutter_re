import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/base/logic/BaseListController.dart';
import 'package:wanandroid_flutter_re/base/logic/state/ListDataUIState.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListModel.dart';
import 'package:wanandroid_flutter_re/entity/article_entity.dart';
import 'package:wanandroid_flutter_re/entity/article_list_entity.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/global/Constant.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/main.dart';

///data为ArticleListEntity的业务逻辑
abstract class BaseWanArticleListController
    extends BaseListController<ArticleEntity, BaseWanArticleListModel> {
  ///账号登录监听
  late Function() _loginListener;

  ///收藏监听
  late Function() _collectListener;

  _init() {
    _loginListener = () {
      extRunWithLogin(
        toLoginPage: false,
        onLogin: () {
          final userInfo = globalAppController.userState.info!;
          userInfo.collectIds?.forEach((collectId) {
            for (var article in data) {
              if (article.id == collectId) {
                article.collect = true;
              }
            }
          });
        },
        onNotLogin: () {
          for (var article in data) {
            article.collect = false;
          }
        },
      );
      updateDataState = dataState;
    };

    _collectListener = () {
      ///把对应item设置为处理收藏事件后的状态
      for (var element in dataState.listData) {
        if (element.id == globalCollectController.collectArticleState.id ||
            element.originId == globalCollectController.collectArticleState.id) {
          element.collect = globalCollectController.collectArticleState.isCollect;
          element.extIsCollecting = false;
          break;
        }
      }

      updateDataState = dataState;
    };

    globalCollectController.subscribe(
        key: Constant.GLOBAL_COLLECT_ARTICLE, listener: _collectListener);

    globalAppController.subscribe(
        key: Constant.GLOBAL_APP_USER_LOGIN_STATE, listener: _loginListener);
  }

  _close() {
    globalCollectController.unSubscribe(
        key: Constant.GLOBAL_COLLECT_ARTICLE, listener: _collectListener);

    globalAppController.unSubscribe(
      key: Constant.GLOBAL_APP_USER_LOGIN_STATE,
      listener: _loginListener,
    );
  }

  ///收藏
  collect({required int id}) {
    globalCollectController.collectArticle(id: id);
  }

  ///取消收藏
  unCollect({required int id}) {
    globalCollectController.uncollectArticle(id: id);
  }

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  @override
  void onClose() {
    _close();
  }

  @override
  bool checkResult(result) {
    final WanCommonResultEntity realResult = result as WanCommonResultEntity;
    return realResult.isSuccess();
  }

  @override
  List<ArticleEntity> convertData(ListDataUIState state, result) {
    final WanCommonResultEntity realResult = result;
    final ArticleListEntity entity = realResult.data;
    final List<ArticleEntity>? datas = entity.datas;
    if (datas.isNullOrEmpty()) {
      return [];
    } else {
      return datas!;
    }
  }

  @override
  bool hasMoreData(result) {
    final WanCommonResultEntity realResult = result;
    final ArticleListEntity entity = realResult.data;
    return !entity.over!;
  }

  @override
  String resultErrMsg(result) {
    final WanCommonResultEntity realResult = result;
    return realResult.errorMsg;
  }
}
