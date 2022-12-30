import 'package:wanandroid_flutter_re/generated/json/base/json_field.dart';
import 'package:wanandroid_flutter_re/generated/json/article_tag_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class ArticleTagEntity {

	late String name;
	late String url;
  
  ArticleTagEntity();

  factory ArticleTagEntity.fromJson(Map<String, dynamic> json) => $ArticleTagEntityFromJson(json);

  Map<String, dynamic> toJson() => $ArticleTagEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}