import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/base/logic/state/FetchDataState.dart';
import 'package:wanandroid_flutter_re/base/net/exception/AppException.dart';
import 'package:wanandroid_flutter_re/base/net/ext/RequestExt.dart';
import 'package:wanandroid_flutter_re/entity/app_settings_entity.dart';
import 'package:wanandroid_flutter_re/entity/login_entity.dart';
import 'package:wanandroid_flutter_re/entity/user_coin_entity.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/global/CacheManager.dart';
import 'package:wanandroid_flutter_re/global/Constant.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/global/state/UserState.dart';
import 'package:wanandroid_flutter_re/model/GlobalAppModel.dart';
import 'package:wanandroid_flutter_re/net/WanService.dart';
import 'package:wanandroid_flutter_re/theme/WanThemes.dart';

class GlobalAppController extends GetxController {
  final _model = GlobalAppModel();

  ///用户信息
  UserState _userState = UserState();

  UserState get userState => _userState;

  ///用户排名 积分信息
  FetchDataState<UserCoinEntity> _userCoinInfoState =
      FetchDataState.creatDefaultState<UserCoinEntity>();

  FetchDataState<UserCoinEntity> get userCoinInfoState => _userCoinInfoState;

  //更新用户金币信息
  set _updateUserCoinInfoState(FetchDataState<UserCoinEntity> state) {
    _userCoinInfoState = state;
    update([Constant.GLOBAL_APP_USER_COIN_INFO]);
  }

  ///功能设置
  AppSettingsEntity _settings = AppSettingsEntity.creatDefault();

  AppSettingsEntity get settings => _settings;

  //更新是否显示置顶文章
  set updateSettingsShowTopArticle(bool showTopArticle) {
    _settings.showTopActicle = showTopArticle;
    _saveSettings(_settings);
    update([Constant.GLOBAL_APP_SETTINGS_SHOW_TOP_ARTICLE]);
  }

  //更新用户头像
  set updateSettingsAvatar(String avatar) {
    _settings.avatar = avatar;
    _saveSettings(_settings);
    update([
      Constant.GLOBAL_APP_SETTINGS_AVATAR,
    ]);
  }

  //更新深色模式
  set updateSettingsDarkMod(bool darkMod) {
    //如果当前模式相同就不更新了
    if (_settings.darkMod == darkMod) {
      return;
    }
    _settings.darkMod = darkMod;
    WanThemes.instance.changeTheme(_settings.themeColorValue, darkMod);
    update([
      Constant.GLOBAL_APP_SETTINGS_THEME_COLOR,
    ]);
  }

  //更新主题跟随系统
  set updateSettingsWithSystemMod(bool withSystemMod) {
    _settings.withSystemMod = withSystemMod;
    _saveSettings(_settings);
    if (withSystemMod) {
      updateSettingsDarkMod = extIsPlatformDarkMod();
    } else {
      updateSettingsDarkMod = extIsDarkMod();
    }

    update([
      Constant.GLOBAL_APP_SETTINGS_WITH_SYSTEM_MOD,
    ]);
  }

  //更新系统主题颜色
  set updateSettingsWithThemeColor(Color color) {
    _settings.themeColorValue = color.value;
    _saveSettings(_settings);
    WanThemes.instance
        .changeTheme(_settings.themeColorValue, _settings.darkMod);
    update([
      Constant.GLOBAL_APP_SETTINGS_THEME_COLOR,
    ]);
  }

  ///初始化数据
  Future init() async {
    await _initSettings();
    await _initUserState();
    //如果登录了账号就先获取用户排名信息
    if (extIsLogin()) {
      netFetchUserCoinInfo();
    }
  }

  ///处理设置
  _initSettings() async {
    var settingsStr = await CacheManager.fetch_settings();
    AppSettingsEntity settings;
    if (settingsStr.isNullOrEmpty()) {
      settings = AppSettingsEntity.creatDefault();
    } else {
      settings = AppSettingsEntity.fromJson(jsonDecode(settingsStr!));
    }
    _settings = settings;
  }

  ///处理登录
  _initUserState() async {
    final infoStr = await CacheManager.fetch_user_info();
    if (infoStr.isNullOrEmpty()) {
      await loginOut();
    } else {
      await loginIn(entity: LoginEntity.fromJson(jsonDecode(infoStr!)));
    }
  }

  ///保存设置
  _saveSettings(final AppSettingsEntity settings) async {
    await CacheManager.save_settings(settings.toString());
  }

  ///获取用户等级和积分等信息
  netFetchUserCoinInfo() {
    if (extIsLogin()) {
      _updateUserCoinInfoState =
          FetchDataState.creatDefaultState<UserCoinEntity>();
      extRequest(
        future: _model.netFetchUserCoinInfo(),
        success: (result) {
          final realResult = result as WanCommonResultEntity;
          final state = FetchDataState.creatDefaultState<UserCoinEntity>();
          state.isSuccess = realResult.isSuccess();
          state.isLoading = false;
          if (realResult.isSuccess()) {
            state.data = realResult.data;
            //这里顺便刷新一下用户的金币数量
            _userState.info!.coinCount = state.data!.coinCount;
            CacheManager.save_user_info(_userState.info.toString());
          } else {
            state.errMessage = realResult.errorMsg;
            state.data = null;
            extShowToast("获取用户信息错误：${realResult.errorMsg}");
          }
          _updateUserCoinInfoState = state;
        },
        failure: (AppException e) {
          final state = FetchDataState.creatDefaultState<UserCoinEntity>();
          state.isSuccess = false;
          state.isLoading = false;
          state.errMessage = e.errorMsg;
          state.data = null;
          _updateUserCoinInfoState = state;
          extShowToast("获取用户信息失败：${e.errorMsg}");
        },
      );
    }
  }

  ///登录
  loginIn({required LoginEntity entity}) async {
    _userState = UserState(info: entity);
    await CacheManager.save_user_info(entity.toString());
    update([
      Constant.GLOBAL_APP_USER_LOGIN_STATE,
      Constant.GLOBAL_APP_USER_COIN_INFO,
    ]);
  }

  ///登出
  loginOut() async {
    _userState = UserState();
    //清除cookie
    requestHandler.clearAllCookie();
    //清除用户信息
    await CacheManager.save_user_info(null);
    //头像重制
    // updateSettingAvatar(AppSettingsEntity.DEF_AVATAR);
    // update([GlobalAppIds.LOGIN_STATUS.name]);
    update([
      Constant.GLOBAL_APP_USER_LOGIN_STATE,
      Constant.GLOBAL_APP_USER_COIN_INFO,
    ]);
  }

  ///更新本地搜索词
  updateHistoryKeywords({required List<dynamic> keywordsList}) async {
    await CacheManager.save_history_keywords(json.encode(keywordsList));
    update([Constant.GLOBAL_APP_SEARCH_KEYWORDS]);
  }

  addHistoryKeyword({required String keywords}) async {
    String? listStr = await CacheManager.fetch_history_keywords();
    if (listStr.isNullOrEmpty()) {
      await updateHistoryKeywords(keywordsList: <String>[keywords]);
    } else {
      List<dynamic> list = json.decode(listStr!);
      //去掉相同的字符串
      for (var element in list) {
        final String elementStr = element;
        if (elementStr == keywords) {
          return;
        }
      }
      list.add(keywords);
      await updateHistoryKeywords(keywordsList: list);
    }
  }

  subscribe({required String key, required Function() listener}) =>
      addListenerId(key, listener);

  unSubscribe({required String key, required Function() listener}) =>
      removeListenerId(key, listener);
}
