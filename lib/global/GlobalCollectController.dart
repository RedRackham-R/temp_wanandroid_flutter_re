import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/base/logic/BaseController.dart';
import 'package:wanandroid_flutter_re/base/net/exception/AppException.dart';
import 'package:wanandroid_flutter_re/base/net/ext/RequestExt.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/global/Constant.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/global/model/GlobalCollectModel.dart';
import 'package:wanandroid_flutter_re/global/state/CollectState.dart';

class GlobalCollectController extends BaseController {
  final GlobalCollectModel _model = GlobalCollectModel();

  ///收藏文章状态
  CollectState _collectArticleState = CollectState(id: -1, isCollect: false);

  CollectState get collectArticleState => _collectArticleState;

  set _updateCollectArticleState(CollectState state) {
    _collectArticleState = state;
    update([Constant.GLOBAL_COLLECT_ARTICLE]);
  }

  ///收藏web状态
  CollectState _collectWebState = CollectState(id: -1, isCollect: false);

  CollectState get collectWebState => _collectWebState;

  set _updateCollectWebState(CollectState state) {
    _collectWebState = state;
    update([Constant.GLOBAL_COLLECT_WEB]);
  }

  ///收藏web
  collectWeb() {}

  ///取消收藏web
  unCollectWeb({required int id}) {
    extRunWithLogin(
      onLogin: () {
        extRequest(
          future: _model.uncollectWeb(id: id),
          success: (result) {
            _handleCollectWebResult(id, false, result);
          },
          failure: (AppException e) {
            _handleCollectWebFailure(id, false, e);
          },
        );
      },
      onNotLogin: () {
        _updateCollectWebState = CollectState(
          id: id,
          isCollect: true,
        );
        extShowToast("请登录后操作");
      },
    );
  }

  _handleCollectWebResult(final int id, final bool isCollect, final result) {
    WanCommonResultEntity realResult = result as WanCommonResultEntity;
    if (realResult.isSuccess()) {
      _updateCollectWebState = CollectState(id: id, isCollect: isCollect);
    } else {
      _updateCollectWebState = CollectState(id: id, isCollect: !isCollect);
      extShowToast(isCollect
          ? "收藏失败,${realResult.errorMsg}"
          : "取消收藏失败,${realResult.errorMsg}");
    }
  }

  _handleCollectWebFailure(final int id, final bool isCollect, AppException e) {
    _updateCollectWebState = CollectState(id: id, isCollect: !isCollect);
    extShowToast(isCollect ? "收藏失败,${e.errorMsg}" : "取消收藏失败,${e.errorMsg}");
  }

  ///收藏文章
  collectArticle({required int id}) =>
      _netFetchCollectArticle(id: id, isCollect: true);

  ///取消收藏
  uncollectArticle({required int id}) =>
      _netFetchCollectArticle(id: id, isCollect: false);

  _netFetchCollectArticle({
    required final int id,
    required final bool isCollect,
  }) {
    extRunWithLogin(
      onLogin: () {
        extRequest(
          future: isCollect
              ? _model.collectArticle(id: id)
              : _model.uncollectArticle(id: id),
          success: (result) {
            _handleCollectArticleResult(id, isCollect, result);
          },
          failure: (AppException e) {
            _handleCollectArticleFailure(id, isCollect, e);
          },
        );
      },
      onNotLogin: () {
        _updateCollectArticleState =
            CollectState(id: id, isCollect: !isCollect);
        extShowToast("请登录后操作");
      },
    );
  }

  _handleCollectArticleResult(
      final int id, final bool isCollect, final result) {
    WanCommonResultEntity realResult = result as WanCommonResultEntity;
    if (realResult.isSuccess()) {
      _updateCollectArticleState = CollectState(id: id, isCollect: isCollect);
    } else {
      _updateCollectArticleState = CollectState(id: id, isCollect: !isCollect);
      extShowToast(isCollect
          ? "收藏失败,${realResult.errorMsg}"
          : "取消收藏失败,${realResult.errorMsg}");
    }
  }

  _handleCollectArticleFailure(
      final int id, final bool isCollect, AppException e) {
    _updateCollectArticleState = CollectState(id: id, isCollect: !isCollect);
    extShowToast(isCollect ? "收藏失败,${e.errorMsg}" : "取消收藏失败,${e.errorMsg}");
  }

  subscribe({required String key, required Function() listener}) =>
      addListenerId(key, listener);

  unSubscribe({required String key, required Function() listener}) =>
      removeListenerId(key, listener);
}
