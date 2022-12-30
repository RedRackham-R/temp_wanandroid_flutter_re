import 'package:wanandroid_flutter_re/generated/json/base/json_field.dart';
import 'package:wanandroid_flutter_re/generated/json/hot_keywords_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class HotKeywordsEntity {
  late int id;
  late String link;
  late String name;
  late int order;
  late int visible;

  HotKeywordsEntity();

  factory HotKeywordsEntity.fromJson(Map<String, dynamic> json) =>
      $HotKeywordsEntityFromJson(json);

  Map<String, dynamic> toJson() => $HotKeywordsEntityToJson(this);

  bool isVisible() => visible == 1;

  @override
  String toString() {
    return jsonEncode(this);
  }
}
