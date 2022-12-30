import 'package:wanandroid_flutter_re/entity/article_entity.dart';
import 'package:wanandroid_flutter_re/generated/json/base/json_field.dart';
import 'package:wanandroid_flutter_re/generated/json/nav_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class NavEntity {

	List<ArticleEntity>? articles;
	int? cid;
	String? name;
  
  NavEntity();

  factory NavEntity.fromJson(Map<String, dynamic> json) => $NavEntityFromJson(json);

  Map<String, dynamic> toJson() => $NavEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
