import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/logic/TutorialListController.dart';

class TutorialListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => TutorialListController(),
      tag: TutorialListController.tag,
    );
  }
}
