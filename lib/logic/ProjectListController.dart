import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListController.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListModel.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListPage.dart';
import 'package:wanandroid_flutter_re/model/ProjectListModel.dart';

class ProjectListController extends BaseWanArticleListController {
  String cid;

  ProjectListController({
    required this.cid,
  });

  @override
  BaseWanArticleListModel creatModel() => ProjectListModel(cid: cid);

  @override
  int get startingIndex => 1;
}
