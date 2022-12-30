import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/logic/SettingController.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}
