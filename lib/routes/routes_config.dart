import 'package:get/route_manager.dart';
import 'package:wanandroid_flutter_re/routes/bindings/CoinBinding.dart';
import 'package:wanandroid_flutter_re/routes/bindings/CoinRankBinding.dart';
import 'package:wanandroid_flutter_re/routes/bindings/IndexBinding.dart';
import 'package:wanandroid_flutter_re/routes/bindings/LoginBinding.dart';
import 'package:wanandroid_flutter_re/routes/bindings/SearchBinding.dart';
import 'package:wanandroid_flutter_re/routes/bindings/SettingsBinding.dart';
import 'package:wanandroid_flutter_re/routes/bindings/ShareBinding.dart';
import 'package:wanandroid_flutter_re/routes/bindings/ShareEditBinding.dart';
import 'package:wanandroid_flutter_re/routes/bindings/ToolsBinding.dart';
import 'package:wanandroid_flutter_re/routes/middleware/AuthLoginMiddleware.dart';
import 'package:wanandroid_flutter_re/ui/pages/IndexPage.dart';
import 'package:wanandroid_flutter_re/ui/pages/coin/CoinPage.dart';
import 'package:wanandroid_flutter_re/ui/pages/coin/CoinRankPage.dart';
import 'package:wanandroid_flutter_re/ui/pages/collect/CollectPage.dart';
import 'package:wanandroid_flutter_re/ui/pages/login/LoginPage.dart';
import 'package:wanandroid_flutter_re/ui/pages/search/SearchPage.dart';
import 'package:wanandroid_flutter_re/ui/pages/settings/SettingsPage.dart';
import 'package:wanandroid_flutter_re/ui/pages/share/ShareEditPage.dart';
import 'package:wanandroid_flutter_re/ui/pages/share/SharePage.dart';
import 'package:wanandroid_flutter_re/ui/pages/splash/SplashPage.dart';
import 'package:wanandroid_flutter_re/ui/pages/tools/ToolsPage.dart';

 class RoutesConfig {
  ///过渡
  static const SPLASH = "/splash";

  ///内容索引
  static const INDEX = "/index";

  ///登录
  static const LOGIN = "/login";

  ///搜索
  static const SEARCH = "/search";

  ///积分
  static const COIN = "/coin";

  ///积分排行
  static const COIN_RANK = "/coin/coin_rank";

  ///收藏
  static const COLLECT = "/collect";

  ///分享文章
  static const SHARE = "/share";

  ///编辑/添加 文章
  static const SHARE_EDIT = "/share/edit";

  ///工具箱
  static const TOOLS = "/tools";

  ///系统设置
  static const SETTINGS = "/settings";

  static final List<GetPage> getPages = [
    GetPage(name: SPLASH, page: () => const SplashPage()),
    GetPage(
      name: INDEX,
      page: () => IndexPage(),
      bindings: [
        IndexBinding(),
      ],
      transition: Transition.fade,
    ),
    GetPage(
      name: LOGIN,
      page: () => const LoginPage(),
      bindings: [
        LoginBinding(),
      ],
      transition: Transition.downToUp,
    ),
    GetPage(
      name: SEARCH,
      page: () => SearchPage(),
      bindings: [
        SearchBinding(),
      ],
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: COIN,
      page: () => CoinPage(),
      bindings: [
        CoinBinding(),
      ],
      transition: Transition.rightToLeft,
      middlewares: [
        AuthLoginMiddleware(),
      ],
    ),
    GetPage(
      name: COIN_RANK,
      page: () => const CoinRankPage(),
      bindings: [
        CoinRankBinding(),
      ],
      transition: Transition.rightToLeft,
      middlewares: [
        AuthLoginMiddleware(),
      ],
    ),

    GetPage(
      name: COLLECT,
      page: () => CollectPage(),
      transition: Transition.rightToLeft,
      middlewares: [
        AuthLoginMiddleware(),
      ],
    ),

    GetPage(
      name: SHARE,
      page: () => const SharePage(),
      transition: Transition.rightToLeft,
      bindings: [
        ShareBinding(),
      ],
      middlewares: [
        AuthLoginMiddleware(),
      ],
    ),
    GetPage(
      name: SHARE_EDIT,
      page: () => ShareEditPage(),
      transition: Transition.rightToLeft,
      bindings: [
        ShareEditBinding(),
      ],
      middlewares: [
        AuthLoginMiddleware(),
      ],
    ),
    GetPage(
      name: TOOLS,
      page: () => const ToolsPage(),
      transition: Transition.rightToLeft,
      bindings: [
        ToolsBinding(),
      ],
    ),
    GetPage(
      name: SETTINGS,
      page: () => const SettingsPage(),
      transition: Transition.rightToLeft,
      bindings: [
        SettingsBinding(),
      ],
    ),
  ];
}
