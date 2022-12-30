import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/logic/LoginController.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
