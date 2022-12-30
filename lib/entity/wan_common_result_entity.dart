import 'package:wanandroid_flutter_re/generated/json/base/json_field.dart';
import 'package:wanandroid_flutter_re/generated/json/wan_common_result_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class WanCommonResultEntity {
  dynamic data;
  int errorCode = -1;
  String errorMsg = "";

  WanCommonResultEntity();

  factory WanCommonResultEntity.fromJson(Map<String, dynamic> json) =>
      $WanCommonResultEntityFromJson(json);

  Map<String, dynamic> toJson() => $WanCommonResultEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }


  bool isSuccess() => errorCode == 0;
}
