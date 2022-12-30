import 'package:wanandroid_flutter_re/generated/json/base/json_convert_content.dart';
import 'package:wanandroid_flutter_re/entity/article_list_entity.dart';
import 'package:wanandroid_flutter_re/entity/article_entity.dart';

ArticleListEntity $ArticleListEntityFromJson(Map<String, dynamic> json) {
	final ArticleListEntity articleListEntity = ArticleListEntity();
	final int? curPage = jsonConvert.convert<int>(json['curPage']);
	if (curPage != null) {
		articleListEntity.curPage = curPage;
	}
	final List<ArticleEntity>? datas = jsonConvert.convertListNotNull<ArticleEntity>(json['datas']);
	if (datas != null) {
		articleListEntity.datas = datas;
	}
	final int? offset = jsonConvert.convert<int>(json['offset']);
	if (offset != null) {
		articleListEntity.offset = offset;
	}
	final bool? over = jsonConvert.convert<bool>(json['over']);
	if (over != null) {
		articleListEntity.over = over;
	}
	final int? pageCount = jsonConvert.convert<int>(json['pageCount']);
	if (pageCount != null) {
		articleListEntity.pageCount = pageCount;
	}
	final int? size = jsonConvert.convert<int>(json['size']);
	if (size != null) {
		articleListEntity.size = size;
	}
	final int? total = jsonConvert.convert<int>(json['total']);
	if (total != null) {
		articleListEntity.total = total;
	}
	return articleListEntity;
}

Map<String, dynamic> $ArticleListEntityToJson(ArticleListEntity entity) {
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