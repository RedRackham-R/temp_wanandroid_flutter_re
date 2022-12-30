import 'package:wanandroid_flutter_re/generated/json/base/json_convert_content.dart';
import 'package:wanandroid_flutter_re/entity/app_settings_entity.dart';
import 'package:flutter/material.dart';




AppSettingsEntity $AppSettingsEntityFromJson(Map<String, dynamic> json) {
	final AppSettingsEntity appSettingsEntity = AppSettingsEntity();
	final bool? showTopActicle = jsonConvert.convert<bool>(json['showTopActicle']);
	if (showTopActicle != null) {
		appSettingsEntity.showTopActicle = showTopActicle;
	}
	final String? avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		appSettingsEntity.avatar = avatar;
	}
	final bool? darkMod = jsonConvert.convert<bool>(json['darkMod']);
	if (darkMod != null) {
		appSettingsEntity.darkMod = darkMod;
	}
	final bool? withSystemMod = jsonConvert.convert<bool>(json['withSystemMod']);
	if (withSystemMod != null) {
		appSettingsEntity.withSystemMod = withSystemMod;
	}
	final int? themeColorValue = jsonConvert.convert<int>(json['themeColorValue']);
	if (themeColorValue != null) {
		appSettingsEntity.themeColorValue = themeColorValue;
	}
	return appSettingsEntity;
}

Map<String, dynamic> $AppSettingsEntityToJson(AppSettingsEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['showTopActicle'] = entity.showTopActicle;
	data['avatar'] = entity.avatar;
	data['darkMod'] = entity.darkMod;
	data['withSystemMod'] = entity.withSystemMod;
	data['themeColorValue'] = entity.themeColorValue;
	return data;
}