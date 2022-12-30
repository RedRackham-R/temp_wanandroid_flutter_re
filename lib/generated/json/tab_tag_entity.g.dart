import 'package:wanandroid_flutter_re/generated/json/base/json_convert_content.dart';
import 'package:wanandroid_flutter_re/entity/tab_tag_entity.dart';

TabTagEntity $TabTagEntityFromJson(Map<String, dynamic> json) {
	final TabTagEntity tabTagEntity = TabTagEntity();
	final List<dynamic>? articleList = jsonConvert.convertListNotNull<dynamic>(json['articleList']);
	if (articleList != null) {
		tabTagEntity.articleList = articleList;
	}
	final String? author = jsonConvert.convert<String>(json['author']);
	if (author != null) {
		tabTagEntity.author = author;
	}
	final List<TabTagChildren>? children = jsonConvert.convertListNotNull<TabTagChildren>(json['children']);
	if (children != null) {
		tabTagEntity.children = children;
	}
	final int? courseId = jsonConvert.convert<int>(json['courseId']);
	if (courseId != null) {
		tabTagEntity.courseId = courseId;
	}
	final String? cover = jsonConvert.convert<String>(json['cover']);
	if (cover != null) {
		tabTagEntity.cover = cover;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		tabTagEntity.desc = desc;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		tabTagEntity.id = id;
	}
	final String? lisense = jsonConvert.convert<String>(json['lisense']);
	if (lisense != null) {
		tabTagEntity.lisense = lisense;
	}
	final String? lisenseLink = jsonConvert.convert<String>(json['lisenseLink']);
	if (lisenseLink != null) {
		tabTagEntity.lisenseLink = lisenseLink;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		tabTagEntity.name = name;
	}
	final int? order = jsonConvert.convert<int>(json['order']);
	if (order != null) {
		tabTagEntity.order = order;
	}
	final int? parentChapterId = jsonConvert.convert<int>(json['parentChapterId']);
	if (parentChapterId != null) {
		tabTagEntity.parentChapterId = parentChapterId;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		tabTagEntity.type = type;
	}
	final bool? userControlSetTop = jsonConvert.convert<bool>(json['userControlSetTop']);
	if (userControlSetTop != null) {
		tabTagEntity.userControlSetTop = userControlSetTop;
	}
	final int? visible = jsonConvert.convert<int>(json['visible']);
	if (visible != null) {
		tabTagEntity.visible = visible;
	}
	return tabTagEntity;
}

Map<String, dynamic> $TabTagEntityToJson(TabTagEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['articleList'] =  entity.articleList;
	data['author'] = entity.author;
	data['children'] =  entity.children?.map((v) => v.toJson()).toList();
	data['courseId'] = entity.courseId;
	data['cover'] = entity.cover;
	data['desc'] = entity.desc;
	data['id'] = entity.id;
	data['lisense'] = entity.lisense;
	data['lisenseLink'] = entity.lisenseLink;
	data['name'] = entity.name;
	data['order'] = entity.order;
	data['parentChapterId'] = entity.parentChapterId;
	data['type'] = entity.type;
	data['userControlSetTop'] = entity.userControlSetTop;
	data['visible'] = entity.visible;
	return data;
}

TabTagChildren $TabTagChildrenFromJson(Map<String, dynamic> json) {
	final TabTagChildren tabTagChildren = TabTagChildren();
	final List<dynamic>? articleList = jsonConvert.convertListNotNull<dynamic>(json['articleList']);
	if (articleList != null) {
		tabTagChildren.articleList = articleList;
	}
	final String? author = jsonConvert.convert<String>(json['author']);
	if (author != null) {
		tabTagChildren.author = author;
	}
	final List<dynamic>? children = jsonConvert.convertListNotNull<dynamic>(json['children']);
	if (children != null) {
		tabTagChildren.children = children;
	}
	final int? courseId = jsonConvert.convert<int>(json['courseId']);
	if (courseId != null) {
		tabTagChildren.courseId = courseId;
	}
	final String? cover = jsonConvert.convert<String>(json['cover']);
	if (cover != null) {
		tabTagChildren.cover = cover;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		tabTagChildren.desc = desc;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		tabTagChildren.id = id;
	}
	final String? lisense = jsonConvert.convert<String>(json['lisense']);
	if (lisense != null) {
		tabTagChildren.lisense = lisense;
	}
	final String? lisenseLink = jsonConvert.convert<String>(json['lisenseLink']);
	if (lisenseLink != null) {
		tabTagChildren.lisenseLink = lisenseLink;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		tabTagChildren.name = name;
	}
	final int? order = jsonConvert.convert<int>(json['order']);
	if (order != null) {
		tabTagChildren.order = order;
	}
	final int? parentChapterId = jsonConvert.convert<int>(json['parentChapterId']);
	if (parentChapterId != null) {
		tabTagChildren.parentChapterId = parentChapterId;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		tabTagChildren.type = type;
	}
	final bool? userControlSetTop = jsonConvert.convert<bool>(json['userControlSetTop']);
	if (userControlSetTop != null) {
		tabTagChildren.userControlSetTop = userControlSetTop;
	}
	final int? visible = jsonConvert.convert<int>(json['visible']);
	if (visible != null) {
		tabTagChildren.visible = visible;
	}
	return tabTagChildren;
}

Map<String, dynamic> $TabTagChildrenToJson(TabTagChildren entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['articleList'] =  entity.articleList;
	data['author'] = entity.author;
	data['children'] =  entity.children;
	data['courseId'] = entity.courseId;
	data['cover'] = entity.cover;
	data['desc'] = entity.desc;
	data['id'] = entity.id;
	data['lisense'] = entity.lisense;
	data['lisenseLink'] = entity.lisenseLink;
	data['name'] = entity.name;
	data['order'] = entity.order;
	data['parentChapterId'] = entity.parentChapterId;
	data['type'] = entity.type;
	data['userControlSetTop'] = entity.userControlSetTop;
	data['visible'] = entity.visible;
	return data;
}