import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/global/CacheManager.dart';
import 'package:wanandroid_flutter_re/net/WanService.dart';

class SearchTagModel {
  Future<WanCommonResultEntity> netFetchHotKeywords() =>
      WanService.fetchHotKeywords();

  ///获取本地历史搜索关键词
  Future<String?> fetchLocalKeywords() => CacheManager.fetch_history_keywords();
}
