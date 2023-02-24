import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/global/Constant.dart';
import 'package:wanandroid_flutter_re/global/GlobalAppController.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/logic/IndexController.dart';
import 'package:wanandroid_flutter_re/main.dart';
import 'package:wanandroid_flutter_re/routes/routes_config.dart';

import 'package:wanandroid_flutter_re/ui/pages/home/HomePage.dart';
import 'package:wanandroid_flutter_re/ui/pages/project/ProjectPage.dart';
import 'package:wanandroid_flutter_re/ui/pages/square/SquarePage.dart';
import 'package:wanandroid_flutter_re/ui/pages/system/SystemPage.dart';
import 'package:wanandroid_flutter_re/ui/pages/wechat/WechatPage.dart';

class IndexPage extends GetView<IndexController> {
  final List<Widget> _pages = [
    const HomePage(),
    const SquarePage(),
    const WechatPage(),
    SystemPage(),
    ProjectPage(),
  ];

  final _titles = <String>["首页", "广场", "公众号", "体系", "项目"];

  final _bnvItems = [
    const BottomNavigationBarItem(
      label: "首页",
      icon: Icon(
        Icons.home,
      ),
    ),
    const BottomNavigationBarItem(
      label: "广场",
      icon: Icon(
        Icons.public,
      ),
    ),
    const BottomNavigationBarItem(
      label: "公众号",
      icon: Icon(
        Icons.wechat,
      ),
    ),
    const BottomNavigationBarItem(
      label: "体系",
      icon: Icon(
        Icons.article,
      ),
    ),
    const BottomNavigationBarItem(
      label: "项目",
      icon: Icon(
        Icons.folder,
      ),
    ),
  ];

  IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: Obx(() {
          return Text(
            _titles[controller.pageIndex],
          );
        }),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {
              Get.toNamed(RoutesConfig.SEARCH);
            },
          ),
        ],
      ),
      body: Obx(() {
        return _pages[controller.pageIndex];
      }),
      bottomNavigationBar: GetBuilder<IndexController>(
        init: controller,
        id: Constant.INDEX_KEY_BNV_VISIBLE,
        builder: (IndexController controller) {
          return Obx(() {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: controller.bnvVisible ? kBottomNavigationBarHeight : 0.0,

              ///添加warp处理超过屏幕布局的问题
              child: Wrap(
                children: [
                  BottomNavigationBar(
                    currentIndex: controller.pageIndex,
                    type: BottomNavigationBarType.fixed,
                    selectedFontSize: 12.sp,
                    selectedIconTheme: IconThemeData(
                      size: 26.w,
                    ),
                    selectedItemColor: extCurrentTheme().primaryIconTheme.color,
                    unselectedFontSize: 10.sp,
                    unselectedIconTheme: IconThemeData(
                      size: 20.w,
                    ),
                    unselectedItemColor:
                        extCurrentTheme().primaryTextTheme.headline1!.color!,
                    showUnselectedLabels: true,
                    showSelectedLabels: true,
                    enableFeedback: false,
                    elevation: 6.0,
                    mouseCursor: SystemMouseCursors.move,
                    items: _bnvItems,
                    onTap: (index) {
                      ///处理按下按钮切换页面还是通知刷新
                      if (controller.pageIndex == index) {
                        controller.updateBnvTapRefresh();
                      } else {
                        controller.updatePageIndex = index;
                      }
                    },
                  ),
                ],
              ),
            );
          });
        },
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _drawerHead(),
            _creatDrawerItem(
              "我的积分",
              icon: const Icon(
                Icons.equalizer,
                color: Colors.greenAccent,
              ),
              rWidget: GetBuilder<GlobalAppController>(
                init: globalAppController,
                id: Constant.GLOBAL_APP_USER_COIN_INFO,
                builder: (GetxController controller) {
                  return Text(
                    extIsLogin()
                        ? globalAppController.userState.info!.coinCount
                            .toString()
                        : "-- --",
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                  );
                },
              ),
              onTap: () {
                Get.toNamed(RoutesConfig.COIN);
              },
            ),
            _creatDrawerItem(
              "我的收藏",
              icon: const Icon(Icons.favorite, color: Colors.redAccent),
              onTap: () {
                Get.toNamed(RoutesConfig.COLLECT);
              },
            ),
            _creatDrawerItem(
              "我的分享",
              icon: const Icon(
                Icons.share,
                color: Colors.blueAccent,
              ),
              onTap: () {
                Get.toNamed(RoutesConfig.SHARE);
              },
            ),
            _creatDrawerItem(
              "工具箱",
              icon: const Icon(
                Icons.home_repair_service,
                color: Colors.teal,
              ),
              onTap: () {
                Get.toNamed(RoutesConfig.TOOLS);
              },
            ),
            _creatDrawerItem(
              "实用教程",
              icon: const Icon(
                Icons.book,
                color: Colors.brown,
              ),
              onTap: () {
                Get.toNamed(RoutesConfig.TUTORIAL);
              },
            ),
            GetBuilder(
              init: globalAppController,
              id: Constant.GLOBAL_APP_SETTINGS_THEME_COLOR,
              builder: (GetxController controller) {
                return _creatDrawerItem(
                  extIsDarkMod() ? "深色模式" : "浅色模式",
                  icon: extIsDarkMod()
                      ? Icon(
                          Icons.dark_mode,
                          color: Colors.yellow.shade200,
                        )
                      : const Icon(
                          Icons.light_mode,
                          color: Colors.orangeAccent,
                        ),
                  onTap: () {
                    if (extIsWithSystemMod()) {
                      extShowToast("无法切换，请先关闭主题跟随系统！");
                    } else {
                      globalAppController.updateSettingsDarkMod =
                          !extIsDarkMod();
                    }
                  },
                );
              },
            ),
            _creatDrawerItem(
              "系统设置",
              icon: const Icon(
                Icons.settings,
                color: Colors.grey,
              ),
              onTap: () {
                Get.toNamed(RoutesConfig.SETTINGS);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _creatDrawerItem(
    String text, {
    required Widget icon,
    required GestureTapCallback onTap,
    Widget? rWidget,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(
          top: 12.h,
          bottom: 12.h,
          left: 18.w,
          right: 18.w,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            SizedBox(
              width: 18.w,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 12.sp,
              ),
            ),
            const Expanded(child: SizedBox()),
            rWidget ?? const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _drawerHead() {
    return GestureDetector(
      onTap: () {
        extRunWithLogin(
          onLogin: () {
            globalAppController.netFetchUserCoinInfo();
          },
        );
      },
      child: GetBuilder(
        init: globalAppController,
        id: Constant.GLOBAL_APP_USER_LOGIN_STATE,
        builder: (GetxController controller) {
          return GetBuilder(
            init: globalAppController,
            id: Constant.GLOBAL_APP_SETTINGS_THEME_COLOR,
            builder: (GlobalAppController controller) {
              return DrawerHeader(
                decoration: BoxDecoration(
                  color: extCurrentTheme().primaryColor,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    extIsLogin()
                        ? GetBuilder<GlobalAppController>(
                            init: globalAppController,
                            id: Constant.GLOBAL_APP_SETTINGS_AVATAR,
                            builder: (GetxController controller) {
                              return Image.asset(
                                globalAppController.settings.avatar,
                                height: 48.h,
                                width: 48.h,
                              );
                            },
                          )
                        : Icon(
                            Icons.account_circle,
                            size: 48.h,
                            color: extCurrentTheme().primaryIconTheme.color,
                          ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      extIsLogin()
                          ? globalAppController.userState.info!.nickname!
                          : "点击登录",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: extCurrentTheme()
                            .primaryTextTheme
                            .bodyLarge!
                            .color!,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    GetBuilder<GlobalAppController>(
                      init: globalAppController,
                      id: Constant.GLOBAL_APP_USER_COIN_INFO,
                      builder: (GetxController controller) {
                        String level = "";
                        String rank = "";
                        extRunWithLogin(
                          toLoginPage: false,
                          onLogin: () {
                            final state = globalAppController.userCoinInfoState;
                            if (state.isLoading) {
                              level = "获取中...";
                              rank = "获取中...";
                            } else {
                              if (state.isSuccess) {
                                level = state.data!.level.toString();
                                rank = state.data!.rank.toString();
                              } else {
                                level = "获取失败";
                                rank = "获取失败";
                              }
                            }
                          },
                          onNotLogin: () {
                            level = "--";
                            rank = "--";
                          },
                        );

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "等级：",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: extCurrentTheme()
                                    .primaryTextTheme
                                    .bodyLarge!
                                    .color!,
                              ),
                            ),
                            Text(
                              level,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: extCurrentTheme()
                                    .primaryTextTheme
                                    .bodyLarge!
                                    .color!,
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              "排名：",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: extCurrentTheme()
                                    .primaryTextTheme
                                    .bodyLarge!
                                    .color!,
                              ),
                            ),
                            Text(
                              rank,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: extCurrentTheme()
                                    .primaryTextTheme
                                    .bodyLarge!
                                    .color!,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
