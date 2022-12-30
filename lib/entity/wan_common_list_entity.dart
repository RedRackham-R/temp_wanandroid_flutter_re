import 'package:wanandroid_flutter_re/generated/json/base/json_field.dart';
import 'package:wanandroid_flutter_re/generated/json/wan_common_list_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class WanCommonListEntity {

	int? curPage;
	List<dynamic>? datas;
	int? offset;
	bool? over;
	int? pageCount;
	int? size;
	int? total;
  
  WanCommonListEntity();

  factory WanCommonListEntity.fromJson(Map<String, dynamic> json) => $WanCommonListEntityFromJson(json);

  Map<String, dynamic> toJson() => $WanCommonListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}