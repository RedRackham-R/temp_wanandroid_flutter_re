import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/base/logic/state/ListDataUIState.dart';
import 'package:wanandroid_flutter_re/base/logic/state/LoadingState.dart';
import 'package:wanandroid_flutter_re/base/net/exception/AppException.dart';
import 'package:wanandroid_flutter_re/base/net/ext/RequestExt.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListController.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListModel.dart';
import 'package:wanandroid_flutter_re/entity/article_entity.dart';
import 'package:wanandroid_flutter_re/entity/private_article_entity.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/generated/json/base/json_convert_content.dart';
import 'package:wanandroid_flutter_re/global/ext/DialogExt.dart';
import 'package:wanandroid_flutter_re/model/ShareArticleModel.dart';

class ShareArticleController extends BaseWanArticleListController {
  static const tag = "ShareArticleController";


  reloadPrivateArticle(){
    reset();
    loadData();
  }


  deleteShareArticle({
    required int id,
  }) {
    extShowLoadingDialog(msg: "删除中...");
    final ShareArticleModel realModel = model as ShareArticleModel;
    extRequest(
      future: realModel.fetchDeleteShareArticle(id: id),
      success: (result) {
        _handleDeleteArticle(id, result);
      },
      failure: (AppException e) {
        _handleFailure(e);
      },
      withLoading: false,
    );
  }

  _handleDeleteArticle(final int id, final dynamic result) {
    extDismissDialog();
    final WanCommonResultEntity realResult = result as WanCommonResultEntity;
    if (realResult.isSuccess()) {
      int targetIndex = -1;

      for (int i = 0; i < data.length; i++) {
        if (data[i].id == id) {
          targetIndex = i;
          break;
        }
      }
      if (targetIndex != -1) {
        dataState.listData.removeAt(targetIndex);
        if (dataState.listData.isEmpty) {
          updateLoadingState = LoadingState(type: LoadStateType.EMPTY);
        } else {
          updateDataState = dataState;
        }
      }
    } else {
      extShowToast(realResult.errorMsg);
    }
  }

  _handleFailure(AppException e) {
    extDismissDialog();
    extShowToast(e.errorMsg);
  }

  @override
  BaseWanArticleListModel creatModel() => ShareArticleModel();

  ///因为分享文章的json格式和普通格式不一样，这里convert时需要处理下
  @override
  List<ArticleEntity> convertData(ListDataUIState state, result) {
    final WanCommonResultEntity realResult = result as WanCommonResultEntity;
    final PrivateArticleEntity privateArticle = realResult.data;
    final List<ArticleEntity?>? datas = jsonConvert
        .convertList<ArticleEntity>(privateArticle.shareArticles.datas);
    final List<ArticleEntity> realDatas = [];
    datas?.forEach((element) {
      realDatas.add(element!);
    });
    return realDatas;
  }

  @override
  bool hasMoreData(result) {
    final WanCommonResultEntity realResult = result as WanCommonResultEntity;
    final PrivateArticleEntity privateArticle = realResult.data;
    return !privateArticle.shareArticles.over!;
  }

  @override
  int get startingIndex => 1;
}
