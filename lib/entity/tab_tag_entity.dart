import 'package:wanandroid_flutter_re/generated/json/base/json_field.dart';
import 'package:wanandroid_flutter_re/generated/json/tab_tag_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class TabTagEntity {

	List<dynamic>? articleList;
	String? author;
	List<TabTagChildren>? children;
	int? courseId;
	String? cover;
	String? desc;
	int? id;
	String? lisense;
	String? lisenseLink;
	String? name;
	int? order;
	int? parentChapterId;
	int? type;
	bool? userControlSetTop;
	int? visible;
  
  TabTagEntity();

  factory TabTagEntity.fromJson(Map<String, dynamic> json) => $TabTagEntityFromJson(json);

  Map<String, dynamic> toJson() => $TabTagEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TabTagChildren {

	List<dynamic>? articleList;
	String? author;
	List<dynamic>? children;
	int? courseId;
	String? cover;
	String? desc;
	int? id;
	String? lisense;
	String? lisenseLink;
	String? name;
	int? order;
	int? parentChapterId;
	int? type;
	bool? userControlSetTop;
	int? visible;
  
  TabTagChildren();

  factory TabTagChildren.fromJson(Map<String, dynamic> json) => $TabTagChildrenFromJson(json);

  Map<String, dynamic> toJson() => $TabTagChildrenToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}