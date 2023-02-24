import 'package:dio/dio.dart';
import 'package:wanandroid_flutter_re/entity/article_entity.dart';
import 'package:wanandroid_flutter_re/entity/article_list_entity.dart';
import 'package:wanandroid_flutter_re/entity/banner_entity.dart';
import 'package:wanandroid_flutter_re/entity/collect_web_entity.dart';
import 'package:wanandroid_flutter_re/entity/hot_keywords_entity.dart';
import 'package:wanandroid_flutter_re/entity/login_entity.dart';
import 'package:wanandroid_flutter_re/entity/nav_entity.dart';
import 'package:wanandroid_flutter_re/entity/private_article_entity.dart';
import 'package:wanandroid_flutter_re/entity/tab_tag_entity.dart';
import 'package:wanandroid_flutter_re/entity/tool_entity.dart';
import 'package:wanandroid_flutter_re/entity/user_coin_entity.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_list_entity.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/generated/json/base/json_convert_content.dart';
import 'package:wanandroid_flutter_re/net/RequestHandler.dart';
import 'package:wanandroid_flutter_re/net/WanAPI.dart';

late RequestHandler requestHandler;

class WanService {
  /// 获取文章页面 GET
  static Future<WanCommonResultEntity> fetchArticleList({
    required int index,
  }) async {
    String path = WanAPI.article_list(index: index);
    final response = await requestHandler.getFetch(path: path);
    final result = _transResponse(
        response, (json) => jsonConvert.convert<ArticleListEntity>(json));
    return result;
  }

  ///置顶文章 GET
  static Future<WanCommonResultEntity> fetchArticleTop() async {
    String path = WanAPI.article_top();
    final response = await requestHandler.getFetch(path: path);
    final result = _transResponse(response,
        (json) => jsonConvert.convertListNotNull<ArticleEntity>(json));
    return result;
  }

  ///banner GET
  static Future<WanCommonResultEntity> fetchBanner() async {
    String path = WanAPI.articel_banner();
    final response = await requestHandler.getFetch(path: path);
    final result = _transResponse(
        response, (json) => jsonConvert.convertListNotNull<BannerEntity>(json));
    return result;
  }

  ///广场 GET
  static Future<WanCommonResultEntity> fetchUserArticle({
    required int index,
  }) async {
    String path = WanAPI.user_article(index: index);
    final response = await requestHandler.getFetch(path: path);
    final result = _transResponse(
        response, (json) => jsonConvert.convert<ArticleListEntity>(json));
    return result;
  }

  ///公众号tag GET
  static Future<WanCommonResultEntity> fetchWechatTag() async {
    String path = WanAPI.wechat_tag();
    final response = await requestHandler.getFetch(path: path);
    final result = _transResponse(
        response, (json) => jsonConvert.convertListNotNull<TabTagEntity>(json));
    return result;
  }

  /// 获取公众号文章 GET
  static Future<WanCommonResultEntity> fetchWechatArticle({
    required String cid,
    required int index,
  }) async {
    String path = WanAPI.wechat_article(cid: cid, index: index);
    final response = await requestHandler.getFetch(path: path);
    final result = _transResponse(
        response, (json) => jsonConvert.convert<ArticleListEntity>(json));
    return result;
  }

  ///体系tag  GET
  static Future<WanCommonResultEntity> fetchSystemTag() async {
    String path = WanAPI.system_tag();
    final response = await requestHandler.getFetch(path: path);
    final result = _transResponse(
        response, (json) => jsonConvert.convertListNotNull<TabTagEntity>(json));
    return result;
  }

  ///导航 GET
  static Future<WanCommonResultEntity> fetchNavi() async {
    String path = WanAPI.navi();
    final response = await requestHandler.getFetch(path: path);
    final result = _transResponse(
        response, (json) => jsonConvert.convertListNotNull<NavEntity>(json));
    return result;
  }

  ///项目tag  GET
  static Future<WanCommonResultEntity> fetchProjectTag() async {
    String path = WanAPI.project_tag();
    final response = await requestHandler.getFetch(path: path);
    final result = _transResponse(
        response, (json) => jsonConvert.convertListNotNull<TabTagEntity>(json));
    return result;
  }

  ///项目文章  GET
  static Future<WanCommonResultEntity> fetchProjectArticle({
    required String cid,
    required int index,
  }) async {
    String path = WanAPI.project_article(index: index);
    final param = <String, dynamic>{};
    param["cid"] = cid;
    final response =
        await requestHandler.getFetch(path: path, queryParameters: param);
    final result = _transResponse(
        response, (json) => jsonConvert.convert<ArticleListEntity>(json));
    return result;
  }

  ///登录 POST
  static Future<WanCommonResultEntity> fetchLogin({
    required String username,
    required String password,
  }) async {
    String path = WanAPI.login();
    final params = <String, dynamic>{};
    params["username"] = username;
    params["password"] = password;
    final response = await requestHandler.postFetch(
      path: path,
      queryParameters: params,
    );
    final result = _transResponse(
        response, (json) => jsonConvert.convert<LoginEntity>(json));
    return result;
  }

  ///注册 POST
  static Future<WanCommonResultEntity> fetchRegist({
    required String username,
    required String password,
  }) async {
    String path = WanAPI.regist();
    final params = <String, dynamic>{};
    params["username"] = username;
    params["password"] = password;
    params["repassword"] = password;
    final response = await requestHandler.postFetch(
      path: path,
      queryParameters: params,
    );
    final result = _transResponse(
        response, (json) => jsonConvert.convert<LoginEntity>(json));
    return result;
  }

  ///个人积分参数 GET
  static Future<WanCommonResultEntity> fetchUserCoinInfo() async {
    String path = WanAPI.user_coin_info();
    final response = await requestHandler.getFetch(path: path);
    final result = _transResponse(
        response, (json) => jsonConvert.convert<UserCoinEntity>(json));
    return result;
  }

  ///收藏站内文章 POST
  static Future<WanCommonResultEntity> fetchCollectAeticle(
      {required int id}) async {
    String path = WanAPI.collect_article(id: id);
    final response = await requestHandler.postFetch(path: path);
    final result =
        _transResponse(response, (json) => null); //只要code返回0就是成功 不用处理转换了
    return result;
  }

  ///取消收藏站内文章 POST
  static Future<WanCommonResultEntity> fetchUncollectAeticle(
      {required int id}) async {
    String path = WanAPI.uncollect_article(id: id);
    final response = await requestHandler.postFetch(path: path);
    final result =
        _transResponse(response, (json) => null); //只要code返回0就是成功 不用处理转换了
    return result;
  }

  ///获取用户积分历史（需要登录）
  static Future<WanCommonResultEntity> fetchUserCoinList(
      {required int index}) async {
    String path = WanAPI.user_coin_list(index: index);
    final response = await requestHandler.getFetch(path: path);
    final result = _transResponse(
        response, (json) => jsonConvert.convert<WanCommonListEntity>(json));
    return result;
  }

  ///获取用户积分排名
  static Future<WanCommonResultEntity> fetchCoinRankList(
      {required int index}) async {
    String path = WanAPI.coin_rank_list(index: index);
    final response = await requestHandler.getFetch(path: path);
    final result = _transResponse(
        response, (json) => jsonConvert.convert<WanCommonListEntity>(json));
    return result;
  }

  ///收藏文章列表
  static Future<WanCommonResultEntity> fetchCollectArticleList(
      {required int index}) async {
    String path = WanAPI.collect_list_article(index: index);
    final response = await requestHandler.getFetch(path: path);
    final result = _transResponse(
        response, (json) => jsonConvert.convert<ArticleListEntity>(json));
    return result;
  }

  ///收藏网页列表
  static Future<WanCommonResultEntity> fetchCollectWebList() async {
    String path = WanAPI.collect_list_web();
    final response = await requestHandler.getFetch(path: path);
    final result = _transResponse(
        response, (json) => jsonConvert.convertList<CollectWebEntity>(json));
    return result;
  }

  ///删除收藏的网页
  static Future<WanCommonResultEntity> fetchDeleteCollectWeb(
      {required int id}) async {
    String path = WanAPI.delete_collect_web();
    final params = <String, dynamic>{};
    params["id"] = id;
    final response = await requestHandler.postFetch(
      path: path,
      queryParameters: params,
    );
    final result = _transResponse(
        response, (json) => jsonConvert.convertList<CollectWebEntity>(json));
    return result;
  }

  ///搜索热词
  static Future<WanCommonResultEntity> fetchHotKeywords() async {
    String path = WanAPI.hot_keywords();
    final response = await requestHandler.getFetch(
      path: path,
    );
    final result = _transResponse(
        response, (json) => jsonConvert.convertList<HotKeywordsEntity>(json));
    return result;
  }

  /// 获取文章页面 GET
  static Future<WanCommonResultEntity> fetchSearch({
    required int index,
    required String keywords,
  }) async {
    String path = WanAPI.search(index: index);

    final params = <String, dynamic>{};
    params["k"] = keywords;
    final response = await requestHandler.postFetch(
      path: path,
      queryParameters: params,
    );
    final result = _transResponse(
        response, (json) => jsonConvert.convert<ArticleListEntity>(json));
    return result;
  }

  ///自己分享的文章列表
  static Future<WanCommonResultEntity> fetchPrivateArticles({
    required int index,
  }) async {
    String path = WanAPI.private_articles(index: index);
    final response = await requestHandler.getFetch(
      path: path,
    );
    final result = _transResponse(
        response, (json) => jsonConvert.convert<PrivateArticleEntity>(json));
    return result;
  }

  ///分享文章
  static Future<WanCommonResultEntity> fetchShareArticle({
    required String title,
    required String link,
  }) async {
    String path = WanAPI.share_article();
    final params = <String, dynamic>{};
    params["title"] = title;
    params["link"] = link;
    final response = await requestHandler.postFetch(
      path: path,
      queryParameters: params,
    );

    ///只要返回成功就行，不需要解析数据
    final result = _transResponse(response, (json) => null);
    return result;
  }

  ///删除自己分享的文章
  static Future<WanCommonResultEntity> fetchDeleteShareArticle({
    required int id,
  }) async {
    String path = WanAPI.delete_share_article(id: id);
    final response = await requestHandler.postFetch(
      path: path,
    );

    ///只要返回成功就行，不需要解析数据
    final result = _transResponse(response, (json) => null);
    return result;
  }

  ///工具箱列表
  static Future<WanCommonResultEntity> fetchToolsList() async {
    String path = WanAPI.tools_list();
    final response = await requestHandler.getFetch(
      path: path,
    );

    final result = _transResponse(
        response, (json) => jsonConvert.convertList<ToolEntity>(json));
    return result;
  }

  ///教程列表
  static Future<WanCommonResultEntity> fetchTutorialList() async {
    String path = WanAPI.tutorial_list();
    final response = await requestHandler.getFetch(
      path: path,
    );

    final result = _transResponse(response,
        (json) => jsonConvert.convertListNotNull<TabTagChildren>(json));
    return result;
  }

  ///单个教程子列表
  static Future<WanCommonResultEntity> fetchTutorialSubList({
    required String cid,
  }) async {
    String path = WanAPI.tutorial_sub_list(cid: cid);
    final response = await requestHandler.getFetch(
      path: path,
    );

    final result = _transResponse(
        response, (json) => jsonConvert.convert<ArticleListEntity>(json));
    return result;
  }

  static WanCommonResultEntity _transResponse(
      Response response, Function(dynamic json) formJson) {
    //处理公共部分
    final Map<String, dynamic> respDataMap = response.data;
    final errorCode = respDataMap["errorCode"];
    final errorMsg = respDataMap["errorMsg"];
    final data = respDataMap["data"];

    final dataEntity = formJson(data);
    final result = WanCommonResultEntity();
    result.data = dataEntity;
    result.errorCode = errorCode;
    result.errorMsg = errorMsg;
    return result;
  }
}
