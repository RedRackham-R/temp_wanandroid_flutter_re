import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/base/page/BaseListPage.dart';
import 'package:wanandroid_flutter_re/global/Constant.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/global/ext/DialogExt.dart';
import 'package:wanandroid_flutter_re/logic/CoinController.dart';
import 'package:wanandroid_flutter_re/main.dart';
import 'package:wanandroid_flutter_re/routes/routes_config.dart';

import 'package:wanandroid_flutter_re/ui/weight/items/CoinItem.dart';

class CoinPage extends StatelessWidget {
  final String _descText = "为了感谢在本站比较活跃的用户，本站开发了签到积分功能。\n\n"
      "后续将根据积分，暂定每月赠送一些小礼品给大家，目前礼品还没想法，可能是图书、电子产品一类，排行榜待开发，到时候会在首页宣布获奖者。\n\n"
      "一、积分规则：\n\n"
      "  1. 每日登陆积分 ： 基数 + 登陆次数  只看登陆天数，不管中间间断没间断。  基数默认为 10，每个基数对应最大值为 10 + 29，然后基数增加为 11 ，从 11 + 0 ~ 11 + 29 ，周而复始。\n\n"
      " （由于本功能上线后，灰度期间有一些 bug，所以部分用户的签到记录会出现同一天同一秒签到两次的情况，这个数据不准备去除了，就当是学艺不精，留下的悔恨的泪水吧。）\n\n"
      "  2. 分享文章  每天仅第一篇会增加积分，避免不必要分享。  基数默认为 10，每个基数对应最大值为 10 + 29，然后基数增加为 11 ，从 11 + 0 ~ 11 + 29 ，周而复始。\n\n"
      "二、积分用途：\n\n"
      "  -领取本站合作礼包，例如：极客时间 199 礼包\n"
      "  -投递文章免审核（一定积分开启）\n"
      "  -投递文章直接进入首页（一定积分开启）\n"
      "  -开发文章功能（一定积分开启）\n"
      "  -每天积分打满\n"
      "  -登录一次\n"
      "  -在广场 tab 分享一次文章（必须要登录，可以无视 1）\n"
      "  -特殊奖励\n"
      "  -报备严重 bug，例如 首页崩溃，严重影响用户体验 +66\n"
      "  -报备其他 bug，或者优化 +10\n\n"
      "  注意 bug 一定要在https://github.com/hongyangAndroid/wanandroid/issues 上提出，确定是 bug 会添加 bug 标签，当然要留下用户名。  会在积分描述说明清楚为何加分。";

  final _controller = Get.find<CoinController>(tag: CoinController.tag);

  //展开高度
  final _expandedHeight = 180.h;
  late ScrollController _scrollController;

  final Duration _hideAnimDuration = const Duration(milliseconds: 50);
  final Duration _showAnimDuration = const Duration(milliseconds: 500);

  CoinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _scrollController = ScrollController();
    final appbar = _creatSliverAppBar(context);
    //滚动监听 处理title显示
    _scrollController.addListener(() {
      //因为NestedScrollView 滚动距离是展开距离（expandedHeight）+状态栏高度+appbar高度，
      //所以这里计算要去掉状态栏和appbar高度，sliverAppbar中的toobarHeight已经整合了两者的高度,所以直接拿
      //展开高度-sliverAppBar高度即可
      final workingHeight = _expandedHeight - appbar.toolbarHeight;

      if (_scrollController.offset > workingHeight) {
        if (!_controller.isShowCoinTitle) {
          _controller.updateShowTitle = true;
          return;
        }
      }

      if (_scrollController.offset < workingHeight) {
        if (_controller.isShowCoinTitle) {
          _controller.updateShowTitle = false;
          return;
        }
      }
    });

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            appbar,
          ];
        },
        body: _CoinHistoryList(
          tag: CoinController.tag,
          refreshScrollController: _scrollController,
        ),
      ),
    );
  }

  SliverAppBar _creatSliverAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: extCurrentTheme().primaryColor,
      expandedHeight: _expandedHeight,
      flexibleSpace: FlexibleSpaceBar(
        title: GetBuilder<CoinController>(
          init: _controller,
          id: Constant.COIN_SHOW_TITLE,
          builder: (controller) {
            return AnimatedOpacity(
              opacity: _controller.isShowCoinTitle ? 1 : 0,
              duration: _controller.isShowCoinTitle
                  ? _showAnimDuration
                  : _hideAnimDuration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //添加一个statusbar高度的填充件，做到去掉statusbar的居中
                  const Text("我的积分："),
                  //添加数字滚动动画
                  Text(
                    globalAppController.userState.info!.coinCount!.toString(),
                  ),
                ],
              ),
            );
          },
        ),
        centerTitle: true,
        background: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //添加一个statusbar高度的填充件，做到去掉statusbar的居中
            SizedBox(
              height: ScreenUtil().statusBarHeight,
            ),
            //添加数字滚动动画
            TweenAnimationBuilder(
              tween: Tween(
                  begin: 0.0,
                  end: globalAppController.userState.info!.coinCount!
                      .toDouble()),
              duration: const Duration(milliseconds: 1200),
              builder: (context, double value, widget) {
                return Text(
                  value.toInt().toString(),
                  style: TextStyle(
                      fontSize: 56.sp,
                      color: extCurrentTheme().colorScheme.inversePrimary),
                );
              },
            ),
          ],
        ),
      ),
      title: GetBuilder<CoinController>(
        init: _controller,
        id: Constant.COIN_SHOW_TITLE,
        builder: (controller) {
          return AnimatedOpacity(
            opacity: _controller.isShowCoinTitle ? 0 : 1,
            duration: _controller.isShowCoinTitle
                ? _hideAnimDuration
                : _showAnimDuration,
            child: const Text("我的积分"),
          );
        },
      ),
      pinned: true,
      leading: IconButton(
        onPressed: () {
          _scrollController.dispose();
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.help_outline,
          ),
          onPressed: () {
            extShowBottomMessageDialog(
              context: context,
              text: _descText,
            );
          },
        ),
        IconButton(
          //积分排行
          onPressed: () => {Get.toNamed(RoutesConfig.COIN_RANK)},
          icon: Icon(
            Icons.military_tech,
            size: 32.w,
          ),
        ),
      ],
    );
  }
}

class _CoinHistoryList extends BaseListPage<CoinController> {
  _CoinHistoryList(
      {required super.tag, required super.refreshScrollController});

  @override
  Widget creatItem( BuildContext context,  int index) {
    return CoinItem(item: controller.data[index]);
  }
}
