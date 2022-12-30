import 'package:wanandroid_flutter_re/generated/json/base/json_convert_content.dart';
import 'package:wanandroid_flutter_re/entity/collect_web_entity.dart';

CollectWebEntity $CollectWebEntityFromJson(Map<String, dynamic> json) {
	final CollectWebEntity collectWebEntity = CollectWebEntity();
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		collectWebEntity.desc = desc;
	}
	final String? icon = jsonConvert.convert<String>(json['icon']);
	if (icon != null) {
		collectWebEntity.icon = icon;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		collectWebEntity.id = id;
	}
	final String? link = jsonConvert.convert<String>(json['link']);
	if (link != null) {
		collectWebEntity.link = link;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		collectWebEntity.name = name;
	}
	final int? order = jsonConvert.convert<int>(json['order']);
	if (order != null) {
		collectWebEntity.order = order;
	}
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		collectWebEntity.userId = userId;
	}
	final int? visible = jsonConvert.convert<int>(json['visible']);
	if (visible != null) {
		collectWebEntity.visible = visible;
	}
	final bool? extIsLoading = jsonConvert.convert<bool>(json['extIsLoading']);
	if (extIsLoading != null) {
		collectWebEntity.extIsLoading = extIsLoading;
	}
	return collectWebEntity;
}

Map<String, dynamic> $CollectWebEntityToJson(CollectWebEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['desc'] = entity.desc;
	data['icon'] = entity.icon;
	data['id'] = entity.id;
	data['link'] = entity.link;
	data['name'] = entity.name;
	data['order'] = entity.order;
	data['userId'] = entity.userId;
	data['visible'] = entity.visible;
	data['extIsLoading'] = entity.extIsLoading;
	return data;
}