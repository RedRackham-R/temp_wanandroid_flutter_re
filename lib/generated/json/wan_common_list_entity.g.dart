import 'package:wanandroid_flutter_re/generated/json/base/json_convert_content.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_list_entity.dart';

WanCommonListEntity $WanCommonListEntityFromJson(Map<String, dynamic> json) {
	final WanCommonListEntity wanCommonListEntity = WanCommonListEntity();
	final int? curPage = jsonConvert.convert<int>(json['curPage']);
	if (curPage != null) {
		wanCommonListEntity.curPage = curPage;
	}
	final List<dynamic>? datas = jsonConvert.convertListNotNull<dynamic>(json['datas']);
	if (datas != null) {
		wanCommonListEntity.datas = datas;
	}
	final int? offset = jsonConvert.convert<int>(json['offset']);
	if (offset != null) {
		wanCommonListEntity.offset = offset;
	}
	final bool? over = jsonConvert.convert<bool>(json['over']);
	if (over != null) {
		wanCommonListEntity.over = over;
	}
	final int? pageCount = jsonConvert.convert<int>(json['pageCount']);
	if (pageCount != null) {
		wanCommonListEntity.pageCount = pageCount;
	}
	final int? size = jsonConvert.convert<int>(json['size']);
	if (size != null) {
		wanCommonListEntity.size = size;
	}
	final int? total = jsonConvert.convert<int>(json['total']);
	if (total != null) {
		wanCommonListEntity.total = total;
	}
	return wanCommonListEntity;
}

Map<String, dynamic> $WanCommonListEntityToJson(WanCommonListEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['curPage'] = entity.curPage;
	data['datas'] =  entity.datas;
	data['offset'] = entity.offset;
	data['over'] = entity.over;
	data['pageCount'] = entity.pageCount;
	data['size'] = entity.size;
	data['total'] = entity.total;
	return data;
}