import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/logic/ToolsController.dart';

class ToolsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ToolsController(),
      tag: ToolsController.tag,
    );
  }
}
