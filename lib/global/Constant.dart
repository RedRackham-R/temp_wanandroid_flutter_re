import 'package:wanandroid_flutter_re/base/BaseConstant.dart';

class Constant {
  ///IndexController4
  //底部导航栏显示更新
  static const INDEX_KEY_BNV_VISIBLE = "index_bnv_visible";

  //底部导航栏图标按下事件
  static const INDEX_KEY_BNV_TAP_REFRESH = "index_bnv_tap_refresh";

  ///LoginController
  //登录和注册页面切换
  static const LOGIN_KEY_CHANGE_PAGE = "login_page_change";

  ///GlobalAppController
  //用户状态改变 登入/登出
  static const GLOBAL_APP_USER_LOGIN_STATE = "global_app_user_login_state";

  //本地搜索关键词
  static const GLOBAL_APP_SEARCH_KEYWORDS = "global_app_search_keywords";

  //用户rank 金币信息
  static const GLOBAL_APP_USER_COIN_INFO = "global_app_user_coin_info";

  //显示置顶文章
  static const GLOBAL_APP_SETTINGS_SHOW_TOP_ARTICLE =
      "global_app_settings_show_top_article";

  //头像变更
  static const GLOBAL_APP_SETTINGS_AVATAR = "global_app_settings_avatar";

  //跟随系统主题
  static const GLOBAL_APP_SETTINGS_WITH_SYSTEM_MOD = "global_app_settings_with_system_mod";

  //主题颜色
  static const GLOBAL_APP_SETTINGS_THEME_COLOR = "global_app_settings_theme_color";

  ///GlobalCollectController
  //收藏文章请求响应
  static const GLOBAL_COLLECT_ARTICLE = "global_collect_article";

  //收藏web请求响应
  static const GLOBAL_COLLECT_WEB = "global_collect_web";

  ///SearchTagController
  //搜索热词更新响应
  static const SEARCH_TAG_HOT_KEYWORDS = "search_tag_hot_keywords";

  //本地搜索历史更新响应
  static const SEARCH_TAG_HISTORY_KEYWORDS = "search_tag_history_keywords";

  ///CoinController
  //显示积分Title文本
  static const COIN_SHOW_TITLE = "coin_show_title";

  ///SettingsController
  //刷新整个页面颜色
  static const SETTINGS_UPDATE_PAGE_COLOR = "settings_update_page_color";
}
