import 'package:wanandroid_flutter_re/generated/json/base/json_field.dart';
import 'package:wanandroid_flutter_re/generated/json/collect_web_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class CollectWebEntity {
  String? desc;
  String? icon;
  int? id;
  String? link;
  String? name;
  int? order;
  int? userId;
  int? visible;

  bool extIsLoading = false;

  CollectWebEntity();

  factory CollectWebEntity.fromJson(Map<String, dynamic> json) =>
      $CollectWebEntityFromJson(json);

  Map<String, dynamic> toJson() => $CollectWebEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
