import 'package:wanandroid_flutter_re/generated/json/base/json_convert_content.dart';
import 'package:wanandroid_flutter_re/entity/article_tag_entity.dart';

ArticleTagEntity $ArticleTagEntityFromJson(Map<String, dynamic> json) {
	final ArticleTagEntity articleTagEntity = ArticleTagEntity();
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		articleTagEntity.name = name;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		articleTagEntity.url = url;
	}
	return articleTagEntity;
}

Map<String, dynamic> $ArticleTagEntityToJson(ArticleTagEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['name'] = entity.name;
	data['url'] = entity.url;
	return data;
}