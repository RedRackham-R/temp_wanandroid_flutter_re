import 'package:wanandroid_flutter_re/entity/article_entity.dart';


import 'package:wanandroid_flutter_re/generated/json/base/json_field.dart';
import 'package:wanandroid_flutter_re/generated/json/article_list_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class ArticleListEntity {

  int? curPage;
  List<ArticleEntity>? datas;
  int? offset;
  bool? over;
  int? pageCount;
  int? size;
  int? total;

  ArticleListEntity();

  factory ArticleListEntity.fromJson(Map<String, dynamic> json) =>
      $ArticleListEntityFromJson(json);

  Map<String, dynamic> toJson() => $ArticleListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }



}