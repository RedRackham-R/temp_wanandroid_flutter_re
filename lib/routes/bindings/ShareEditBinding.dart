import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/logic/ShareEditPageController.dart';

class ShareEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ShareEditPageController(),
    );
  }
}
