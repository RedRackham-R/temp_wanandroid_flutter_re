import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/base/BaseConstant.dart';
import 'package:wanandroid_flutter_re/base/logic/BaseListController.dart';
import 'package:wanandroid_flutter_re/base/page/state_pages.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';

abstract class BaseListPage<C extends BaseListController>
    extends StatelessWidget {
  EasyRefreshController? refreshController;
  ScrollController? refreshScrollController;
  String tag;
  late C controller;

  ///列表可见状态
  bool _isVisible = false;

  ///刷新状态
  bool _isRefreshing = false;

  ///------------------------可重写----------------------------------------------
  ///使用全局的controller
  bool useGlobalController = false;

  BaseListPage({
    required this.tag,
    this.refreshController,
    this.refreshScrollController,
  }) : super(key: Key(tag)) {
    controller = Get.find<C>(tag: tag);
    refreshController ??= EasyRefreshController(
      controlFinishLoad: true,
      controlFinishRefresh: true,
    );
    refreshScrollController ??= ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return StatePage(
      controller: controller,
      onPressed: () {
        controller.refreshData();
      },
      childBuilder: () {
        return _creatDataPage();
      },
    );
  }

  Widget _creatDataPage() {
    return GetBuilder<C>(
      init: controller,
      global: useGlobalController,
      id: BaseConstant.BASE_KEY_UPDATE_DATA_STATE,
      initState: (GetBuilderState state) {
        _init();
      },
      dispose: (GetBuilderState state) {
        _dispose();
      },
      builder: (C controller) {
        _handleRefreshState();
        return EasyRefresh(
          scrollController: refreshScrollController,
          controller: refreshController,
          header: const ClassicHeader(),
          footer: const ClassicFooter(),
          onLoad: controller.dataState.hasMore
              ? () {
                  controller.loadData();
                }
              : null,
          onRefresh: () {
            _isRefreshing = true;
            controller.refreshData();
          },
          child: creatList(),
        );
      },
    );
  }

  void _init() {
    _isVisible = true;
  }

  void _dispose() {
    _isVisible = false;
    // refreshController?.dispose();
    // refreshScrollController?.dispose();
    // listScrollControler?.dispose();
  }

  _handleRefreshState() {
    _isRefreshing = false;
    final dataState = controller.dataState;
    if (dataState.isSuccess) {
      if (dataState.isRefresh) {
        if (dataState.hasMore) {
          refreshController!.finishRefresh(IndicatorResult.success);
        } else {
          refreshController!.finishRefresh(IndicatorResult.success);
          refreshController!.finishLoad(IndicatorResult.noMore);
        }
      } else {
        if (dataState.hasMore) {
          refreshController!.finishLoad(IndicatorResult.success);
        } else {
          refreshController!.finishLoad(IndicatorResult.noMore);
        }
      }
    } else {
      if (dataState.isRefresh) {
        refreshController!.finishRefresh(IndicatorResult.fail);
      } else {
        refreshController!.finishLoad(IndicatorResult.fail);
      }
    }
  }

  int _headersCount() {
    return headers().isNullOrEmpty() ? 0 : headers()!.length;
  }

  int _footersCount() {
    return footers().isNullOrEmpty() ? 0 : footers()!.length;
  }

  List<Widget>? headers() {
    return null;
  }

  List<Widget>? footers() {
    return null;
  }

  Widget creatList() {
    return CustomScrollView(
      slivers: <Widget>[
        // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
        // headList() ?? const SliverToBoxAdapter(child: SizedBox(),),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (_headersCount() + controller.data.length + _footersCount() ==
                  0) {
                return const SizedBox();
              }
              if (index < _headersCount()) {
                return headers()![index];
              }
              if (index < _headersCount() + controller.data.length) {
                final int realItemIndex = index - _headersCount();

                return creatItem(
                  context,
                  realItemIndex,
                );
              }
              return footers()![index];
            },
            childCount:
                _headersCount() + controller.data.length + _footersCount(),
          ),
        ),
        // footList() ?? const SliverToBoxAdapter(child: SizedBox(),),
      ],
    );
  }

  Widget creatItem(BuildContext context, int index) {
    return Container(
      alignment: Alignment.center,
      height: 50.h,
      color: (index % 2 == 0) ? Colors.blueAccent : Colors.red,
      child: Text(
        controller.data[index].toString(),
      ),
    );
  }
}
