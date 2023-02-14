import 'package:wanandroid_flutter_re/generated/json/base/json_convert_content.dart';
import 'package:wanandroid_flutter_re/entity/cookie_entity.dart';

CookieEntity $CookieEntityFromJson(Map<String, dynamic> json) {
	final CookieEntity cookieEntity = CookieEntity();
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		cookieEntity.name = name;
	}
	final String? value = jsonConvert.convert<String>(json['value']);
	if (value != null) {
		cookieEntity.value = value;
	}
	return cookieEntity;
}

Map<String, dynamic> $CookieEntityToJson(CookieEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['name'] = entity.name;
	data['value'] = entity.value;
	return data;
}