import 'package:flutter/src/foundation/key.dart';
import 'package:wanandroid_flutter_re/base/page/BaseDefaultPage.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanDefaultController.dart';

abstract class BaseWanDefaultPage<C extends BaseWanDefaultController>
    extends BaseDefaultPage<C> {
  BaseWanDefaultPage({Key? key, required super.tag}) : super(key: key);
}
