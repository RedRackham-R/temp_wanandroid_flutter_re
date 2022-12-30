import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/base/BaseConstant.dart';
import 'package:wanandroid_flutter_re/base/logic/BaseController.dart';
import 'package:wanandroid_flutter_re/base/logic/state/LoadingState.dart';

class EmptyPage extends StatelessWidget {
  VoidCallback onPressed;

  EmptyPage({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 120.h,
            ),
            Icon(
              Icons.error,
              size: 50.h,
              color: Colors.grey,
            ),
            SizedBox(
              height: 32.h,
            ),
            Text(
              "暂无数据~",
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
            const Expanded(child: SizedBox()),
            OutlinedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0))),
              ),
              child: Text(
                "点击刷新",
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(
              height: 80.h,
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  VoidCallback onPressed;
  String text;

  ErrorPage({
    Key? key,
    required this.onPressed,
    this.text = "数据获取失败，请检查网络是否连接。",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 120.h,
            ),
            Icon(
              Icons.error,
              size: 50.h,
              color: Colors.grey,
            ),
            SizedBox(
              height: 32.h,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
            const Expanded(child: SizedBox()),
            OutlinedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0))),
              ),
              child: Text(
                "点击刷新",
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(
              height: 80.h,
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.grey,
          valueColor: AlwaysStoppedAnimation(Colors.green),
        ),
      ),
    );
  }
}

///状态页面 根据BaseController中的loading状态进行改变
class StatePage extends StatelessWidget {
  BaseController controller;
  final VoidCallback onPressed;
  Widget Function() childBuilder;
  void Function(GetBuilderState state)? initState;
  void Function(GetBuilderState state)? dispose;

  StatePage({
    Key? key,
    required this.controller,
    required this.onPressed,
    required this.childBuilder,
    this.initState,
    this.dispose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BaseController>(
      global: false,
      init: controller,
      id: BaseConstant.BASE_KEY_UPDATE_LOADING_STATE,
      initState: initState,
      dispose: dispose,
      builder: (BaseController controller) {
        final type = controller.loadingState.type;
        if (type == LoadStateType.LOADING) {
          return LoadingPage();
        } else if (type == LoadStateType.FAILURE) {
          return ErrorPage(onPressed: onPressed);
        } else if (type == LoadStateType.EMPTY) {
          return EmptyPage(onPressed: onPressed);
        } else {
          return childBuilder();
        }
      },
    );
  }
}
