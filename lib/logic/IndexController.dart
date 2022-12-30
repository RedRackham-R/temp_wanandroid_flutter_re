import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/global/Constant.dart';
import 'package:wanandroid_flutter_re/logic/HomeController.dart';
import 'package:wanandroid_flutter_re/logic/ProjectController.dart';
import 'package:wanandroid_flutter_re/logic/SquareController.dart';
import 'package:wanandroid_flutter_re/logic/WechatController.dart';

class IndexController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _initPageController();
  }

  ///页面下标
  var _pageIndex = 0.obs;

  int get pageIndex => _pageIndex.value;

  set updatePageIndex(int index) {
    _pageIndex.value = index;
  }

  ///底部栏显示状态
  var _bnvVisible = true;

  bool get bnvVisible => _bnvVisible;

  set updateBnvVisible(bool visible) {
    _bnvVisible = visible;
    update([Constant.INDEX_KEY_BNV_VISIBLE]);
  }

  ///通知浮动按钮按下
  updateBnvTapRefresh() {
    update([Constant.INDEX_KEY_BNV_TAP_REFRESH]);
  }

  ///初始化各个page的controller 使用fenix每次都会调用创建方法创建一个新的controller，
  ///防止切换页面后controller从内存销毁，造成再次返回页面无法获取到controller的问题
  ///这里配置的controller都是单例，所以会每次获取相同的controller
  _initPageController() {
    Get.lazyPut(() => HomeController.instance,
        fenix: true, tag: HomeController.tag);
    Get.lazyPut(() => SquareController.instance,
        fenix: true, tag: SquareController.tag);
    Get.lazyPut(() => WechatController.instance,
        fenix: true, tag: WechatController.tag);
    Get.lazyPut(() => ProjectController.instance,
        fenix: true, tag: ProjectController.tag);
  }
}
