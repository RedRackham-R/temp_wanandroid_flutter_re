import 'package:wanandroid_flutter_re/generated/json/base/json_convert_content.dart';
import 'package:wanandroid_flutter_re/entity/private_article_entity.dart';
import 'package:wanandroid_flutter_re/entity/article_list_entity.dart';

import 'package:wanandroid_flutter_re/entity/wan_common_list_entity.dart';


PrivateArticleEntity $PrivateArticleEntityFromJson(Map<String, dynamic> json) {
	final PrivateArticleEntity privateArticleEntity = PrivateArticleEntity();
	final WanCommonListEntity? shareArticles = jsonConvert.convert<WanCommonListEntity>(json['shareArticles']);
	if (shareArticles != null) {
		privateArticleEntity.shareArticles = shareArticles;
	}
	return privateArticleEntity;
}

Map<String, dynamic> $PrivateArticleEntityToJson(PrivateArticleEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['shareArticles'] = entity.shareArticles.toJson();
	return data;
}