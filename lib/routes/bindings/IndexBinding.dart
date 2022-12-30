import 'package:get/instance_manager.dart';
import 'package:wanandroid_flutter_re/logic/IndexController.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IndexController(), fenix: true);
  }
}
