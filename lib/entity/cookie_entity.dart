import 'package:wanandroid_flutter_re/generated/json/base/json_field.dart';
import 'package:wanandroid_flutter_re/generated/json/cookie_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class CookieEntity {

	String? name;
	String? value;
  
  CookieEntity();

  factory CookieEntity.fromJson(Map<String, dynamic> json) => $CookieEntityFromJson(json);

  Map<String, dynamic> toJson() => $CookieEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}