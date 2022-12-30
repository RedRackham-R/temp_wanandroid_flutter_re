import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/net/WanService.dart';

class GlobalCollectModel {
  ///收藏文章
  Future<WanCommonResultEntity> collectArticle({required int id}) =>
      WanService.fetchCollectAeticle(id: id);

  ///取消收藏文章
  Future<WanCommonResultEntity> uncollectArticle({required int id}) =>
      WanService.fetchUncollectAeticle(id: id);

  ///取消收藏web
  Future<WanCommonResultEntity> uncollectWeb({required int id}) =>
      WanService.fetchDeleteCollectWeb(id: id);
}
