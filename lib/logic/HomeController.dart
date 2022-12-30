import 'package:wanandroid_flutter_re/base/logic/state/ListDataUIState.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListController.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListModel.dart';
import 'package:wanandroid_flutter_re/entity/article_entity.dart';
import 'package:wanandroid_flutter_re/entity/article_list_entity.dart';
import 'package:wanandroid_flutter_re/entity/banner_entity.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/model/HomeModel.dart';

///首页逻辑，重写各项判断，因为要同时请求banner数据以及置顶广告数据
class HomeController extends BaseWanArticleListController {
  static const String tag = "HomeController";
  ///单例创建对象 HomeController 需要持久化 所以不需要每次都创建
  static HomeController? _instance;

  static HomeController get instance {
    _instance ??= HomeController._internal();
    return _instance!;
  }

  HomeController._internal();

  @override
  List<ArticleEntity> convertData(ListDataUIState state, result) {
    final List<WanCommonResultEntity> realResult = result;
    final List<ArticleEntity> list = [];
    //----------------文章列表
    final WanCommonResultEntity articleResult = realResult[0];
    ArticleListEntity entity0 = articleResult.data as ArticleListEntity;
    if (!entity0.datas.isNullOrEmpty()) {
      list.addAll(entity0.datas!);
    }
    //----------------banner列表
    if (realResult.length > 1) {
      final WanCommonResultEntity bannerResult = realResult[1];
      final banners = bannerResult.data as List<BannerEntity>?;
      if (!banners.isNullOrEmpty()) {
        //使用额外数据来保存banner
        state.extraListData1 = banners!;
      }
    }
    //----------------置顶广告
    if (realResult.length > 2) {
      final WanCommonResultEntity topArticleResult = realResult[2];
      final topArticle = topArticleResult.data as List<ArticleEntity>?;
      if (!topArticle.isNullOrEmpty()) {
        //放到列表前面
        list.insertAll(0, topArticle!);
      }
    }
    return list;
  }

  @override
  BaseWanArticleListModel creatModel() => HomeModel();

  @override
  bool hasMoreData(result) {
    final List<WanCommonResultEntity> realResult = result;
    ArticleListEntity entity = realResult[0].data as ArticleListEntity;
    return !entity.over!;
  }

  @override
  bool checkResult(result) {
    final List<WanCommonResultEntity> realResult = result;
    //只看banner和数据列表是否成功
    return realResult[0].isSuccess();
  }

  @override
  String resultErrMsg(result) {
    final List<WanCommonResultEntity> realResult = result;
    if (!realResult[0].isSuccess()) {
      return realResult[0].errorMsg;
    }
    if (!realResult[1].isSuccess()) {
      return realResult[1].errorMsg;
    }

    if (realResult.length > 2) {
      if (!realResult[2].isSuccess()) {
        return realResult[2].errorMsg;
      }
    }
    return "未知异常";
  }
}
