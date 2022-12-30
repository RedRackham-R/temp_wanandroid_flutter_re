import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/net/WanService.dart';

class EditShareArticleModel {
  Future<WanCommonResultEntity> fetchShareArticle({
    required String title,
    required String link,
  }) =>
      WanService.fetchShareArticle(title: title, link: link);
}
