import 'package:wanandroid_flutter_re/generated/json/base/json_convert_content.dart';
import 'package:wanandroid_flutter_re/entity/nav_entity.dart';
import 'package:wanandroid_flutter_re/entity/article_entity.dart';


NavEntity $NavEntityFromJson(Map<String, dynamic> json) {
	final NavEntity navEntity = NavEntity();
	final List<ArticleEntity>? articles = jsonConvert.convertListNotNull<ArticleEntity>(json['articles']);
	if (articles != null) {
		navEntity.articles = articles;
	}
	final int? cid = jsonConvert.convert<int>(json['cid']);
	if (cid != null) {
		navEntity.cid = cid;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		navEntity.name = name;
	}
	return navEntity;
}

Map<String, dynamic> $NavEntityToJson(NavEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['articles'] =  entity.articles?.map((v) => v.toJson()).toList();
	data['cid'] = entity.cid;
	data['name'] = entity.name;
	return data;
}