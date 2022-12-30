import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/logic/SearchController.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController());
  }
}
