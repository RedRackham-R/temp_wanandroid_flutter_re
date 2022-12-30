import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///listview滚动状态管理类，方便获取到顶部的位置以及滚动方向获取
class ListScrollControllerManager {
  late ScrollController controller;
  var visible = true;

  ListScrollControllerManager({required double initialScrollOffset,
    Function(bool)? visibleAction, Function(double)? offsetAction}) {
    controller = ScrollController(initialScrollOffset: initialScrollOffset);

    controller.addListener(
      () {
        if (offsetAction != null) {
          offsetAction(controller.offset);
        }

        if (visibleAction != null) {
          if (controller.position.userScrollDirection ==
              ScrollDirection.reverse) {
            if (visible) {
              visible = false;
              visibleAction(false);
            }
          }

          if (controller.position.userScrollDirection ==
              ScrollDirection.forward) {
            if (!visible) {
              visible = true;
              visibleAction(true);
            }
          }
        }
      },
    );
  }

  scrollAnimateToTop() {
    if(controller.hasClients){
      controller.jumpTo(0.0);
      visible = true;
    }

  }

  void dispose() {
    controller.dispose();
  }
}
