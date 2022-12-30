import 'package:wanandroid_flutter_re/generated/json/base/json_convert_content.dart';
import 'package:wanandroid_flutter_re/entity/coin_list_entity.dart';

CoinListEntity $CoinListEntityFromJson(Map<String, dynamic> json) {
	final CoinListEntity coinListEntity = CoinListEntity();
	final int? curPage = jsonConvert.convert<int>(json['curPage']);
	if (curPage != null) {
		coinListEntity.curPage = curPage;
	}
	final List<CoinListDatas>? datas = jsonConvert.convertListNotNull<CoinListDatas>(json['datas']);
	if (datas != null) {
		coinListEntity.datas = datas;
	}
	final int? offset = jsonConvert.convert<int>(json['offset']);
	if (offset != null) {
		coinListEntity.offset = offset;
	}
	final bool? over = jsonConvert.convert<bool>(json['over']);
	if (over != null) {
		coinListEntity.over = over;
	}
	final int? pageCount = jsonConvert.convert<int>(json['pageCount']);
	if (pageCount != null) {
		coinListEntity.pageCount = pageCount;
	}
	final int? size = jsonConvert.convert<int>(json['size']);
	if (size != null) {
		coinListEntity.size = size;
	}
	final int? total = jsonConvert.convert<int>(json['total']);
	if (total != null) {
		coinListEntity.total = total;
	}
	return coinListEntity;
}

Map<String, dynamic> $CoinListEntityToJson(CoinListEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['curPage'] = entity.curPage;
	data['datas'] =  entity.datas?.map((v) => v.toJson()).toList();
	data['offset'] = entity.offset;
	data['over'] = entity.over;
	data['pageCount'] = entity.pageCount;
	data['size'] = entity.size;
	data['total'] = entity.total;
	return data;
}

CoinListDatas $CoinListDatasFromJson(Map<String, dynamic> json) {
	final CoinListDatas coinListDatas = CoinListDatas();
	final int? coinCount = jsonConvert.convert<int>(json['coinCount']);
	if (coinCount != null) {
		coinListDatas.coinCount = coinCount;
	}
	final int? date = jsonConvert.convert<int>(json['date']);
	if (date != null) {
		coinListDatas.date = date;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		coinListDatas.desc = desc;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		coinListDatas.id = id;
	}
	final String? reason = jsonConvert.convert<String>(json['reason']);
	if (reason != null) {
		coinListDatas.reason = reason;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		coinListDatas.type = type;
	}
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		coinListDatas.userId = userId;
	}
	final String? userName = jsonConvert.convert<String>(json['userName']);
	if (userName != null) {
		coinListDatas.userName = userName;
	}
	return coinListDatas;
}

Map<String, dynamic> $CoinListDatasToJson(CoinListDatas entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['coinCount'] = entity.coinCount;
	data['date'] = entity.date;
	data['desc'] = entity.desc;
	data['id'] = entity.id;
	data['reason'] = entity.reason;
	data['type'] = entity.type;
	data['userId'] = entity.userId;
	data['userName'] = entity.userName;
	return data;
}