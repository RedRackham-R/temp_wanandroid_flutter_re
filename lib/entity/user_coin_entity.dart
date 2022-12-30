import 'package:wanandroid_flutter_re/generated/json/base/json_field.dart';
import 'package:wanandroid_flutter_re/generated/json/user_coin_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class UserCoinEntity {

	int? coinCount;
	int? level;
	String? nickname;
	String? rank;
	int? userId;
	String? username;
  
  UserCoinEntity();

  factory UserCoinEntity.fromJson(Map<String, dynamic> json) => $UserCoinEntityFromJson(json);

  Map<String, dynamic> toJson() => $UserCoinEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }



}