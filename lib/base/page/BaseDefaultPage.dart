import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/base/logic/BaseDefaultController.dart';
import 'package:wanandroid_flutter_re/base/page/state_pages.dart';

abstract class BaseDefaultPage<C extends BaseDefaultController>
    extends StatelessWidget {
  String tag;
  late C controller;

  BaseDefaultPage({
    Key? key,
    required this.tag,
  }) : super(key: key) {
    controller = Get.find<C>(tag: tag);
  }

  @override
  Widget build(BuildContext context) {
    return StatePage(
      controller: controller,
      onPressed: () {
        onPress();
      },
      childBuilder: () {
        return successPage(context);
      },
      initState: (GetBuilderState state) {
        getInitState(state);
      },
      dispose: (GetBuilderState state) {
        getDispose(state);
      },
    );
  }

  Widget successPage(BuildContext context);

  void onPress();

  void getInitState(GetBuilderState state) {}

  void getDispose(GetBuilderState state) {}
}
