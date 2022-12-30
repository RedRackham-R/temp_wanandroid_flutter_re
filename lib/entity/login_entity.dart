import 'package:wanandroid_flutter_re/generated/json/base/json_field.dart';
import 'package:wanandroid_flutter_re/generated/json/login_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class LoginEntity {

	bool? admin;
	List<dynamic>? chapterTops;
	int? coinCount;
	List<int>? collectIds;
	String? email;
	String? icon;
	int? id;
	String? nickname;
	String? password;
	String? publicName;
	String? token;
	int? type;
	String? username;
  
  LoginEntity();

  factory LoginEntity.fromJson(Map<String, dynamic> json) => $LoginEntityFromJson(json);

  Map<String, dynamic> toJson() => $LoginEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}