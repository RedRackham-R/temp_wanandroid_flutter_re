import 'package:wanandroid_flutter_re/generated/json/base/json_field.dart';
import 'package:wanandroid_flutter_re/generated/json/tool_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class ToolEntity {
	String? desc;
	String? icon;
	int? id;
	int? isNew;
	String? link;
	String? name;
	int? order;
	int? showInTab;
	String? tabName;
	int? visible;
  
  ToolEntity();

  factory ToolEntity.fromJson(Map<String, dynamic> json) => $ToolEntityFromJson(json);

  Map<String, dynamic> toJson() => $ToolEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}