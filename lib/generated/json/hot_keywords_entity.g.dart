import 'package:wanandroid_flutter_re/generated/json/base/json_convert_content.dart';
import 'package:wanandroid_flutter_re/entity/hot_keywords_entity.dart';

HotKeywordsEntity $HotKeywordsEntityFromJson(Map<String, dynamic> json) {
	final HotKeywordsEntity hotKeywordsEntity = HotKeywordsEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		hotKeywordsEntity.id = id;
	}
	final String? link = jsonConvert.convert<String>(json['link']);
	if (link != null) {
		hotKeywordsEntity.link = link;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		hotKeywordsEntity.name = name;
	}
	final int? order = jsonConvert.convert<int>(json['order']);
	if (order != null) {
		hotKeywordsEntity.order = order;
	}
	final int? visible = jsonConvert.convert<int>(json['visible']);
	if (visible != null) {
		hotKeywordsEntity.visible = visible;
	}
	return hotKeywordsEntity;
}

Map<String, dynamic> $HotKeywordsEntityToJson(HotKeywordsEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['link'] = entity.link;
	data['name'] = entity.name;
	data['order'] = entity.order;
	data['visible'] = entity.visible;
	return data;
}