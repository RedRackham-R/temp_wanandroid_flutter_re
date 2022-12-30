import 'package:wanandroid_flutter_re/generated/json/base/json_convert_content.dart';
import 'package:wanandroid_flutter_re/entity/tool_entity.dart';

ToolEntity $ToolEntityFromJson(Map<String, dynamic> json) {
	final ToolEntity toolEntity = ToolEntity();
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		toolEntity.desc = desc;
	}
	final String? icon = jsonConvert.convert<String>(json['icon']);
	if (icon != null) {
		toolEntity.icon = icon;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		toolEntity.id = id;
	}
	final int? isNew = jsonConvert.convert<int>(json['isNew']);
	if (isNew != null) {
		toolEntity.isNew = isNew;
	}
	final String? link = jsonConvert.convert<String>(json['link']);
	if (link != null) {
		toolEntity.link = link;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		toolEntity.name = name;
	}
	final int? order = jsonConvert.convert<int>(json['order']);
	if (order != null) {
		toolEntity.order = order;
	}
	final int? showInTab = jsonConvert.convert<int>(json['showInTab']);
	if (showInTab != null) {
		toolEntity.showInTab = showInTab;
	}
	final String? tabName = jsonConvert.convert<String>(json['tabName']);
	if (tabName != null) {
		toolEntity.tabName = tabName;
	}
	final int? visible = jsonConvert.convert<int>(json['visible']);
	if (visible != null) {
		toolEntity.visible = visible;
	}
	return toolEntity;
}

Map<String, dynamic> $ToolEntityToJson(ToolEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['desc'] = entity.desc;
	data['icon'] = entity.icon;
	data['id'] = entity.id;
	data['isNew'] = entity.isNew;
	data['link'] = entity.link;
	data['name'] = entity.name;
	data['order'] = entity.order;
	data['showInTab'] = entity.showInTab;
	data['tabName'] = entity.tabName;
	data['visible'] = entity.visible;
	return data;
}