class WanAPI {
  static const BASE_URL = "https://www.wanandroid.com/";

  ///首页文章列表
  /// https://www.wanandroid.com/article/list/0/json
  static String article_list({required index}) => "article/list/$index/json";

  ///置顶文章
  /// https://www.wanandroid.com/article/top/json
  static String article_top() => "article/top/json";

  ///banner
  ///https://www.wanandroid.com/banner/json
  static String articel_banner() => "banner/json";

  ///广场
  ///https://wanandroid.com/user_article/list/0/json
  static String user_article({required index}) =>
      "user_article/list/$index/json";

  ///公众号tag
  ///https://wanandroid.com/wxarticle/chapters/json
  static String wechat_tag() => "wxarticle/chapters/json";

  ///公众号文章列表
  ///https://wanandroid.com/wxarticle/list/408/1/json
  static String wechat_article({required cid, required index}) =>
      "wxarticle/list/$cid/$index/json";

  ///体系tag
  ///https://www.wanandroid.com/tree/json
  static String system_tag() => "tree/json";

  ///导航
  ///https://www.wanandroid.com/navi/json
  static String navi() => "navi/json";

  ///项目tag
  ///https://www.wanandroid.com/project/tree/json
  static String project_tag() => "project/tree/json";

  ///项目文章列表
  ///https://www.wanandroid.com/project/list/1/json?cid=294
  static String project_article({required index}) => "project/list/$index/json";

  ///登录
  ///https://www.wanandroid.com/user/login
  static String login() => "user/login";

  ///注册
  ///https://www.wanandroid.com/user/register
  static String regist() => "user/register";

  ///个人积分排名数据 需要登录以后才去获取
  ///https://www.wanandroid.com/lg/coin/userinfo/json
  static String user_coin_info() => "lg/coin/userinfo/json";

  ///收藏站内文章
  ///https://www.wanandroid.com/lg/collect/1165/json
  static String collect_article({required id}) => "lg/collect/$id/json";

  ///取消收藏站内文章
  ///https://www.wanandroid.com/lg/uncollect_originId/2333/json
  static String uncollect_article({required id}) =>
      "lg/uncollect_originId/$id/json";

  ///获取个人积分历史（需要登录）
  ///https://www.wanandroid.com/lg/coin/list/1/json
  static String user_coin_list({required index}) => "lg/coin/list/$index/json";

  ///获取积分排行接口
  ///https://www.wanandroid.com/coin/rank/1/json
  static String coin_rank_list({required index}) => "coin/rank/$index/json";

  ///收藏文章列表
  ///https://www.wanandroid.com/lg/collect/list/0/json
  static String collect_list_article({required index}) =>
      "lg/collect/list/$index/json";

  ///收藏网页列表
  ///https://www.wanandroid.com/lg/collect/usertools/json
  static String collect_list_web() => "lg/collect/usertools/json";

  ///删除网页收藏
  ///https://www.wanandroid.com/lg/collect/deletetool/json
  static String delete_collect_web() => "lg/collect/deletetool/json";

  ///搜索热词
  ///https://www.wanandroid.com/hotkey/json
  static String hot_keywords() => "hotkey/json";

  ///关键词搜索
  ///https://www.wanandroid.com/article/query/0/json
  static String search({required index}) => "article/query/$index/json";

  ///自己分享的文章列表
  ///https://wanandroid.com/user/lg/private_articles/1/json
  static String private_articles({required index}) =>
      "user/lg/private_articles/$index/json";

  ///分享文章
  ///https://wanandroid.com/lg/user_article/add/json
  static String share_article() => "lg/user_article/add/json";

  ///删除自己分享的文章
  ///https://wanandroid.com/lg/user_article/delete/9475/json
  static String delete_share_article({required id}) =>
      "lg/user_article/delete/$id/json";

  ///工具箱
  ///https://wanandroid.com/tools/list/json
  static String tools_list() => "tools/list/json";
}
