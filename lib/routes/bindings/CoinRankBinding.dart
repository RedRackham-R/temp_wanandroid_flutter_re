import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/logic/CoinRankController.dart';

class CoinRankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CoinRankController(),
      tag: CoinRankController.tag,
    );
  }
}
