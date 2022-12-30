import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/logic/ShareArticleController.dart';

class ShareBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ShareArticleController(),
      tag: ShareArticleController.tag,
    );
  }
}
