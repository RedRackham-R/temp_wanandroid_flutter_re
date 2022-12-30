import 'package:wanandroid_flutter_re/generated/json/base/json_convert_content.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';

WanCommonResultEntity $WanCommonResultEntityFromJson(Map<String, dynamic> json) {
	final WanCommonResultEntity wanCommonResultEntity = WanCommonResultEntity();
	final dynamic? data = jsonConvert.convert<dynamic>(json['data']);
	if (data != null) {
		wanCommonResultEntity.data = data;
	}
	final int? errorCode = jsonConvert.convert<int>(json['errorCode']);
	if (errorCode != null) {
		wanCommonResultEntity.errorCode = errorCode;
	}
	final String? errorMsg = jsonConvert.convert<String>(json['errorMsg']);
	if (errorMsg != null) {
		wanCommonResultEntity.errorMsg = errorMsg;
	}
	return wanCommonResultEntity;
}

Map<String, dynamic> $WanCommonResultEntityToJson(WanCommonResultEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['data'] = entity.data;
	data['errorCode'] = entity.errorCode;
	data['errorMsg'] = entity.errorMsg;
	return data;
}