import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/logic/CoinController.dart';

class CoinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CoinController(),
      tag: CoinController.tag,
    );
  }
}
