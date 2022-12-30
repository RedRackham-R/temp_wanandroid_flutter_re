import 'package:wanandroid_flutter_re/generated/json/base/json_field.dart';
import 'package:wanandroid_flutter_re/generated/json/banner_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class BannerEntity {

	String? desc;
	int? id;
	String? imagePath;
	int? isVisible;
	int? order;
	String? title;
	int? type;
	String? url;
  
  BannerEntity();

  factory BannerEntity.fromJson(Map<String, dynamic> json) => $BannerEntityFromJson(json);

  Map<String, dynamic> toJson() => $BannerEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}