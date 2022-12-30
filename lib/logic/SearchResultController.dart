import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListController.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListModel.dart';
import 'package:wanandroid_flutter_re/model/SearchResultModel.dart';

class SearchResultController extends BaseWanArticleListController {
  static const tag = "SearchResultController";
  String _keyword = "";

  String get keyword => _keyword;

  set updateKeyword(String keyword) {
    _keyword = keyword;
    (model as SearchResultModel).keyword = keyword;
    reset();
    refreshData();
  }

  SearchResultController(String keyword) {
    _keyword = keyword;
  }

  @override
  BaseWanArticleListModel creatModel() => SearchResultModel(keyword);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
