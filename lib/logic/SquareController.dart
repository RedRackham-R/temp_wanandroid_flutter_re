import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListController.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListModel.dart';
import 'package:wanandroid_flutter_re/model/SquareModel.dart';

///广场逻辑模块
class SquareController extends BaseWanArticleListController {
  static const String tag = "SquareController";
  ///单例创建对象 SquareController 需要持久化 所以不需要每次都创建
  static SquareController? _instance;

  static SquareController get instance {
    _instance ??= SquareController._internal();

    return _instance!;
  }

  SquareController._internal();

  @override
  BaseWanArticleListModel creatModel() => SquareModel();
}
