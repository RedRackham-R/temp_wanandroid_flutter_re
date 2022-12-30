import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/global/Constant.dart';
import 'package:wanandroid_flutter_re/global/GlobalAppController.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/global/ext/DialogExt.dart';
import 'package:wanandroid_flutter_re/global/ext/ThemeExt.dart';
import 'package:wanandroid_flutter_re/logic/SettingController.dart';
import 'package:wanandroid_flutter_re/main.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: controller,
      id: Constant.SETTINGS_UPDATE_PAGE_COLOR,
      builder: (SettingsController controller) {
        return Scaffold(
          backgroundColor: extCurrentTheme().cardColor,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: extUseColorWithDarkMod(
              targetColor: controller.curColor,
              darkModColor: extCurrentTheme().primaryColor,
            ),
            title: const Text(
              "系统设置",
            ),
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          body: EasyRefresh(
            child: ListView(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
              ),
              children: [
                ///基本设置
                _creatTitleItem(
                  title: "基本设置",
                ),

                ///显示置顶文章
                _creatContentItem(
                  title: "显示置顶文章",
                  subTitle: "显示置顶的文章，刷新首页或者重启生效",
                  rWidget: GetBuilder<GlobalAppController>(
                    init: globalAppController,
                    id: Constant.GLOBAL_APP_SETTINGS_SHOW_TOP_ARTICLE,
                    builder: (GlobalAppController globalAppController) {
                      return Switch(
                        activeColor: extUseColorWithDarkMod(
                          targetColor: controller.curColor,
                        ),
                        value: globalAppController.settings.showTopActicle,
                        onChanged: (bool value) {
                          globalAppController.updateSettingsShowTopArticle =
                              value;
                        },
                      );
                    },
                  ),
                ),
                _itemLineSpace(),
                GetBuilder<SettingsController>(
                  init: controller,
                  id: "cacheSizeText",
                  builder: (SettingsController controller) {
                    return _creatContentItem(
                      title: "清除缓存",
                      subTitle: "-- --",
                      // subTitle: controller.cacheSizeText,
                      onTap: () {
                        extShowComfrimDialog(
                          title: "确认",
                          content: "是否删除缓存",
                          barrierDismissible: true,
                          onConfirm: () => {
                            extDismissDialog(),
                            // controller.cleanCache(),
                            extShowToast("缓存已清理"),
                          },
                          cancel: () => {},
                        );
                      },
                    );
                  },
                ),
                GetBuilder<GlobalAppController>(
                  init: globalAppController,
                  id: Constant.GLOBAL_APP_USER_LOGIN_STATE,
                  builder: (GlobalAppController globalController) {
                    return extIsLogin() ? _itemLineSpace() : const SizedBox();
                  },
                ),
                GetBuilder<GlobalAppController>(
                  init: globalAppController,
                  id: Constant.GLOBAL_APP_USER_LOGIN_STATE,
                  builder: (GlobalAppController globalcontroller) {
                    if (extIsLogin()) {
                      return _creatContentItem(
                        title: "退出登录",
                        subTitle: "退出当前账号登录状态",
                        rWidget: GetBuilder<GlobalAppController>(
                          init: globalcontroller,
                          id: Constant.GLOBAL_APP_USER_COIN_INFO,
                          builder: (GlobalAppController globalcontroller) {
                            return Text(
                              globalcontroller.userCoinInfoState.data == null
                                  ? "获取中..."
                                  : globalAppController
                                      .userCoinInfoState.data!.username
                                      .toString(),
                              style: TextStyle(
                                color: extUseColorWithDarkMod(
                                  targetColor: controller.curColor,
                                ),
                              ),
                            );
                          },
                        ),
                        onTap: () {
                          extShowComfrimDialog(
                            title: "确认",
                            content: "是否退出登录？",
                            barrierDismissible: true,
                            cancel: () {},
                            onConfirm: () {
                              globalcontroller.loginOut();
                              extDismissDialog();
                              extShowToast("已登出");
                            },
                          );
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                _creatTitleItem(
                  title: "主题相关",
                ),
                GetBuilder<GlobalAppController>(
                  init: globalAppController,
                  id: Constant.GLOBAL_APP_USER_LOGIN_STATE,
                  builder: (GlobalAppController globalController) {
                    if (extIsLogin()) {
                      return _creatContentItem(
                        title: "修改头像",
                        subTitle: "选择更改头像",
                        rWidget: GetBuilder<GlobalAppController>(
                          init: globalAppController,
                          id: Constant.GLOBAL_APP_SETTINGS_AVATAR,
                          builder: (GlobalAppController globalController) {
                            return SizedBox(
                              height: 36.w,
                              width: 36.w,
                              child: Image.asset(
                                globalAppController.settings.avatar,
                              ),
                            );
                          },
                        ),
                        onTap: () {
                          extShowAvatarPickerDialog();
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                GetBuilder<GlobalAppController>(
                  init: globalAppController,
                  id: Constant.GLOBAL_APP_USER_LOGIN_STATE,
                  builder: (GlobalAppController globalController) {
                    return extIsLogin() ? _itemLineSpace() : const SizedBox();
                  },
                ),
                _creatContentItem(
                  title: "主题修改",
                  subTitle: "修改主题颜色",
                  rWidget: CircleColor(
                    color: extIsDarkMod()
                        ? extCurrentTheme().primaryColor
                        : controller.curColor,
                    circleSize: 36.w,
                  ),
                  onTap: () {
                    if (extIsDarkMod()) {
                      extShowToast("请退出夜间模式再设置主题");
                    } else {
                      extShowMaterialColorPickerDialog(
                        onMainColorChange: (ColorSwatch<dynamic>? value) {
                          controller.updatePageColor = value!;
                        },
                        onComfrim: (Color color) {
                          globalAppController.updateSettingsWithThemeColor =
                              color;
                        },
                        onCancel: () => {
                          controller.updatePageColor =
                              extCurrentTheme().primaryColor,
                        },
                      );
                    }
                  },
                ),
                _itemLineSpace(),
                _creatContentItem(
                  title: "切换模式",
                  subTitle: "切换为：${extIsDarkMod() ? "浅色模式" : "深色模式"}",
                  rWidget: extIsDarkMod()
                      ? Icon(
                          Icons.dark_mode,
                          size: 36.w,
                          color: extUseColorWithDarkMod(
                            targetColor: controller.curColor,
                            darkModColor: Colors.yellow,
                          ),
                        )
                      : Icon(
                          Icons.light_mode,
                          size: 36.w,
                          color: Colors.orange,
                        ),
                  onTap: () {
                    if (globalAppController.settings.withSystemMod) {
                      extShowToast("无法切换，请关闭主题模式跟随系统选项");
                    } else {
                      globalAppController.updateSettingsDarkMod =
                          !extIsDarkMod();
                      controller.updatePageColor =
                          extCurrentTheme().primaryColor;
                    }
                  },
                ),
                _itemLineSpace(),
                _creatContentItem(
                  title: "主题模式跟随系统",
                  subTitle: "浅色/深色主题跟随系统设置切换",
                  rWidget: GetBuilder<GlobalAppController>(
                    init: globalAppController,
                    id: Constant.GLOBAL_APP_SETTINGS_WITH_SYSTEM_MOD,
                    builder: (GlobalAppController globalController) {
                      return Switch(
                        activeColor: extUseColorWithDarkMod(
                          targetColor: controller.curColor,
                        ),
                        value: globalController.settings.withSystemMod,
                        onChanged: (bool value) {
                          globalController.updateSettingsWithSystemMod = value;
                          controller.updatePageColor =
                              extCurrentTheme().primaryColor;
                        },
                      );
                    },
                  ),
                ),

                _creatTitleItem(
                  title: "关于",
                ),
                _creatContentItem(
                  title: "版本:",
                  subTitle: "v1.0.0",
                ),
                _itemLineSpace(),
                _creatContentItem(
                  title: "声明",
                  subTitle: "本软件遵循GPLv3通用公共许可协议",
                  onTap: () {
                    extShowToast(
                        "打开https://www.gnu.org/licenses/gpl-3.0.en.html");
                  },
                ),
                _itemLineSpace(),
                _creatContentItem(
                  title: "特别感谢",
                  subTitle: "https://www.wanandroid.com/",
                  rWidget: Container(
                    color: Colors.white,
                    height: 36.w,
                    width: 36.w,
                    child: Image.asset(
                      "assets/images/pic/wanandroid_logo.png",
                    ),
                  ),
                  onTap: () {
                    extShowToast("打开https://www.wanandroid.com/");
                  },
                ),
                _itemLineSpace(),
                _creatContentItem(
                  title: "作者",
                  subTitle: "https://github.com/lxy409875745",
                  rWidget: Image.asset(
                    "assets/images/avatars/red_rackham.png",
                    width: 36.w,
                    height: 36.w,
                  ),
                  onTap: () {
                    extShowToast("打开https://github.com/lxy409875745");
                  },
                ),
                _itemLineSpace(),
              ],
            ),
          ),
        );
      },
    );
  }

  ///创建title类型的item
  Widget _creatTitleItem({required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24.h,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            color: extUseColorWithDarkMod(
              targetColor: controller.curColor,
            ),
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
      ],
    );
  }

  ///创建内容item
  Widget _creatContentItem({
    required String title,
    String? subTitle,
    Widget? rWidget,
    VoidCallback? onTap,
  }) {
    //处理标题和副标题
    List<Widget> titles = [];
    titles.add(
      Title(
        color: extUseColorWithDarkMod(
          targetColor: extCurrentTheme().primaryColor,
        ),
        child: Text(
          title,
        ),
      ),
    );
    if (!subTitle.isNullOrEmpty()) {
      titles.add(
        SizedBox(
          height: 4.h,
        ),
      );
      titles.add(
        Text(
          subTitle!,
          style: TextStyle(
            color: extCurrentTheme().textTheme.headline1!.color!,
            fontSize: 12.sp,
          ),
        ),
      );
    }
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: titles,
          ),
          const Expanded(child: SizedBox()),
          rWidget ?? const SizedBox(),
        ],
      ),
    );
  }

  _itemLineSpace() => SizedBox(
        height: 20.h,
      );
}
