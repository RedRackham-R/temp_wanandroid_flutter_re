import 'dart:convert';

import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/base/logic/BaseController.dart';
import 'package:wanandroid_flutter_re/base/net/exception/AppException.dart';
import 'package:wanandroid_flutter_re/base/net/ext/RequestExt.dart';
import 'package:wanandroid_flutter_re/entity/hot_keywords_entity.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/global/Constant.dart';
import 'package:wanandroid_flutter_re/main.dart';
import 'package:wanandroid_flutter_re/model/SearchTagModel.dart';

class SearchTagController extends BaseController {
  final _model = SearchTagModel();

  ///热门搜索
  final _hotKeywords = <HotKeywordsEntity?>[];

  List<HotKeywordsEntity?> get hotKeywords => _hotKeywords;

  set _updateHotKeywords(List<HotKeywordsEntity?> list) {
    _hotKeywords.clear();
    _hotKeywords.addAll(list);
    update([Constant.SEARCH_TAG_HOT_KEYWORDS]);
  }

  ///历史记录
  final _historyKeywords = <String>[];

  List<String> get localKeywords => _historyKeywords;

  set updateKeywords(List<String>? keywords) {
    _historyKeywords.clear();
    if (keywords != null) {
      _historyKeywords.addAll(keywords);
    }
    globalAppController.updateHistoryKeywords(keywordsList: _historyKeywords);
    update([Constant.SEARCH_TAG_HISTORY_KEYWORDS]);
  }

  @override
  void onReady() {
    _fetchHotKeywords();
  }

  clearHistory() {
    updateKeywords = null;
  }

  _fetchHotKeywords() {
    extRequest(
      future: _model.netFetchHotKeywords(),
      success: (result) {
        _handleHotKeywordsResult(result);
      },
      failure: (AppException e) {},
    );
  }

  fetchLocalKeywords() {
    extRequest(
      future: _model.fetchLocalKeywords(),
      success: (result) {
        _handleLocalKeywordsResult(result);
      },
      failure: (AppException e) {},
    );
  }

  _handleLocalKeywordsResult(String? result) {
    if (!result.isNullOrEmpty()) {
      final List<dynamic>? temp = json.decode(result!);
      if (temp != null) {
        updateKeywords = temp.cast<String>();
      }
    }
  }

  _handleHotKeywordsResult(WanCommonResultEntity result) {
    if (result.isSuccess()) {
      final data = result.data as List<HotKeywordsEntity?>;
      _updateHotKeywords = data;
    }
  }
}
