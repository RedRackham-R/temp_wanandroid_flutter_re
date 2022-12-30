import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:wanandroid_flutter_re/global/Constant.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanDefualtPage.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/logic/IndexController.dart';
import 'package:wanandroid_flutter_re/logic/SystemListController.dart';

import 'package:wanandroid_flutter_re/ui/weight/items/SystemItem.dart';
import 'package:wanandroid_flutter_re/ui/weight/weight_controller/ListScrollControllerManager.dart';

///体系列表页面
class SystemListPage extends BaseWanDefaultPage<SystemListController> {
  final IndexController _indexController = Get.find<IndexController>();
  late ListScrollControllerManager _scrollControllerManager;
  late GetStateUpdate _bnvTapControlListener;
  bool _isVisible = false;

  ///列表是否在顶部状态
  bool _isInTop = true;

  SystemListPage({Key? key}) : super(key: key, tag: SystemListController.tag);

  @override
  void getInitState(GetBuilderState state) {
    //显示状态
    _isVisible = true;

    //处理bnv点击监听
    _bnvTapControlListener = () {
      if (_isVisible) {
        if (_isInTop) {
        } else {
          _scrollControllerManager.scrollAnimateToTop();
          extShowToast("已返回顶部");
        }
      }
    };
    _indexController.addListenerId(
        Constant.INDEX_KEY_BNV_TAP_REFRESH, _bnvTapControlListener);

    //设置是否在顶部的缓存
    _isInTop = (controller.listOffset < 60.h);
    _indexController.addListenerId(
        Constant.INDEX_KEY_BNV_TAP_REFRESH, _bnvTapControlListener);
    _scrollControllerManager = ListScrollControllerManager(
      //设置滚动缓存
      initialScrollOffset: controller.listOffset,
      visibleAction: (visible) {
        _indexController.updateBnvVisible = visible;
      },
      offsetAction: (offset) {
        //配置offset
        if (offset < 0) {
          controller.listOffset = 0;
        } else {
          controller.listOffset = offset;
        }
        //配置置顶状态
        if (offset < 60.h) {
          _isInTop = true;
        } else {
          _isInTop = false;
        }
      },
    );
  }

  @override
  void getDispose(GetBuilderState<GetxController> state) {
    _isVisible = false;
    _scrollControllerManager.dispose();
    _indexController.removeListenerId(
        Constant.INDEX_KEY_BNV_TAP_REFRESH, _bnvTapControlListener);
  }

  @override
  void onPress() {
    controller.loadData();
  }

  @override
  Widget successPage(BuildContext context) {
    return Container(
      color: extCurrentTheme().cardColor,
      child: EasyRefresh(
        child: ListView.builder(
          controller: _scrollControllerManager.controller,
          itemCount: controller.data!.length,
          itemBuilder: (
            BuildContext context,
            int index,
          ) {
            return SystemItem(
              data: controller.data![index],
              onTap: (item) {
                extShowToast("点击了${item.name}");
              },
            );
          },
        ),
      ),
    );
  }
}
