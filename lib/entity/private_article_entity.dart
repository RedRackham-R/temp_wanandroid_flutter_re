import 'package:wanandroid_flutter_re/entity/article_list_entity.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_list_entity.dart';
import 'package:wanandroid_flutter_re/generated/json/base/json_field.dart';
import 'package:wanandroid_flutter_re/generated/json/private_article_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class PrivateArticleEntity {

	late WanCommonListEntity shareArticles;

  PrivateArticleEntity();

  factory PrivateArticleEntity.fromJson(Map<String, dynamic> json) => $PrivateArticleEntityFromJson(json);

  Map<String, dynamic> toJson() => $PrivateArticleEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}