import 'package:flutter/material.dart';
import 'package:wanandroid_flutter_re/generated/json/base/json_field.dart';
import 'package:wanandroid_flutter_re/generated/json/app_settings_entity.g.dart';
import 'dart:convert';

import 'package:wanandroid_flutter_re/theme/WanThemes.dart';



@JsonSerializable()
class AppSettingsEntity {
  late bool showTopActicle;
  late String avatar;
  late bool darkMod;
  late bool withSystemMod;
  late int themeColorValue;

  AppSettingsEntity({
    this.showTopActicle = DEF_SHOW_TOP_ACTICLE,
    this.avatar = DEF_AVATAR,
    this.darkMod = DEF_DARKMOD,
    this.withSystemMod = DEF_WITH_SYSTEM_MOD,
    this.themeColorValue = 0,
  });

  factory AppSettingsEntity.fromJson(Map<String, dynamic> json) =>
      $AppSettingsEntityFromJson(json);

  Map<String, dynamic> toJson() => $AppSettingsEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

  ///设置默认值
  static const bool DEF_SHOW_TOP_ACTICLE = true;
  static const String DEF_AVATAR = "assets/images/avatars/avatar1.png";
  static const bool DEF_DARKMOD = false;
  static const bool DEF_WITH_SYSTEM_MOD = false;

  ///创建默认
  static AppSettingsEntity creatDefault() => AppSettingsEntity(
        showTopActicle: DEF_SHOW_TOP_ACTICLE,
        avatar: DEF_AVATAR,
        darkMod: DEF_DARKMOD,
        withSystemMod: DEF_WITH_SYSTEM_MOD,
        themeColorValue: WanThemes.themeColors[0].value,
      );

  Color convertThemeColor() {
    return WanThemes.getThemeColor(themeColorValue);
  }
}
