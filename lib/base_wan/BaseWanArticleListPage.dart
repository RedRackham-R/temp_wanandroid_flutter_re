import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:wanandroid_flutter_re/base/BaseConstant.dart';
import 'package:wanandroid_flutter_re/base/page/state_pages.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListController.dart';
import 'package:wanandroid_flutter_re/entity/article_entity.dart';
import 'package:wanandroid_flutter_re/global/Constant.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/global/GlobalAppController.dart';
import 'package:wanandroid_flutter_re/logic/IndexController.dart';
import 'package:wanandroid_flutter_re/main.dart';
import 'package:wanandroid_flutter_re/ui/weight/items/ArticleItem.dart';
import 'package:wanandroid_flutter_re/ui/weight/weight_controller/ListScrollControllerManager.dart';

abstract class BaseWanArticleListPage<C extends BaseWanArticleListController>
    extends StatelessWidget {
  final IndexController _indexController = Get.find<IndexController>();
  late EasyRefreshController _refreshController;

  late ListScrollControllerManager _scrollControllerManager;
  String tag;
  late C controller;

  ///列表是否在顶部状态
  bool _isInTop = true;

  ///列表可见状态
  bool _isVisible = false;

  ///刷新状态
  bool _isRefreshing = false;
  GetStateUpdate? _bnvTapControlListener;

  ///------------------------可重写----------------------------------------------
  ///使用全局的controller
  bool useGlobalController = false;

  ///是否开启控制底部导航栏显示
  bool useControlBnv = true;

  BaseWanArticleListPage({required this.tag}) : super(key: Key(tag)) {
    controller = Get.find<C>(tag: tag);
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return StatePage(
      controller: controller,
      onPressed: () {
        controller.refreshData();
      },
      childBuilder: () {
        return _creatListPage();
      },
    );
  }

  Widget _creatListPage() {
    return GetBuilder<C>(
      init: controller,
      global: useGlobalController,
      id: BaseConstant.BASE_KEY_UPDATE_DATA_STATE,
      initState: (GetBuilderState state) {},
      dispose: (GetBuilderState state) {
        _dispose();
      },
      builder: (C controller) {
        _handleRefreshState();
        return EasyRefresh(
          controller: _refreshController,
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
    if (useControlBnv) {
      //设置
      _bnvTapControlListener = () {
        if (_isVisible) {
          if (_isInTop) {
            if (!_isRefreshing) {
              _refreshController.callRefresh();
            }
          } else {
            _scrollControllerManager.scrollAnimateToTop();
            extShowToast("已返回顶部");
          }
        }
      };
      //设置是否在顶部的缓存
      _isInTop = (controller.listOffset < 60.h);
      _indexController.addListenerId(
          Constant.INDEX_KEY_BNV_TAP_REFRESH, _bnvTapControlListener!);
    }

    _refreshController = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );

    _scrollControllerManager = ListScrollControllerManager(
      //设置滚动缓存
      initialScrollOffset: controller.listOffset,
      visibleAction: (visible) {
        if (useControlBnv) {
          _indexController.updateBnvVisible = visible;
        }
      },
      offsetAction: (offset) {
        //配置offset
        if (offset < 0) {
          controller.updateListOffset = 0;
        } else {
          controller.updateListOffset = offset;
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

  void _dispose() {
    _isVisible = false;
    if (_bnvTapControlListener != null) {
      _indexController.removeListenerId(
          Constant.INDEX_KEY_BNV_TAP_REFRESH, _bnvTapControlListener!);
    }
    _refreshController.dispose();
    _scrollControllerManager.dispose();
  }

  _handleRefreshState() {
    _isRefreshing = false;
    final dataState = controller.dataState;
    if (dataState.isSuccess) {
      if (dataState.isRefresh) {
        if (dataState.hasMore) {
          _refreshController.finishRefresh(IndicatorResult.success);
        } else {
          _refreshController.finishLoad(IndicatorResult.noMore);
          _refreshController.finishRefresh(IndicatorResult.success);
        }
      } else {
        if (dataState.hasMore) {
          _refreshController.finishLoad(IndicatorResult.success);
        } else {
          _refreshController.finishLoad(IndicatorResult.noMore);
        }
      }
    } else {
      if (dataState.isRefresh) {
        _refreshController.finishRefresh(IndicatorResult.fail);
      } else {
        _refreshController.finishLoad(IndicatorResult.fail);
      }
    }
  }

  int _headersCount() {
    return headers().isNullOrEmpty() ? 0 : headers()!.length;
  }

  int _footersCount() {
    return footers().isNullOrEmpty() ? 0 : footers()!.length;
  }

  Widget creatList() {
    return CustomScrollView(
      controller: _scrollControllerManager.controller,
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
                return creatItem(context, realItemIndex);
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
    return GetBuilder<GlobalAppController>(
      init: globalAppController,
      id: Constant.GLOBAL_APP_SETTINGS_THEME_COLOR,
      builder: (GlobalAppController globalAppController) {
        return ArticleItem(
          article: controller.data[index],
          onCollectTap: (ArticleEntity data) {
            data.extIsCollecting = true;
            data.collect!
                ? controller.unCollect(
                    id: data.originId == null ? data.id! : data.originId!)
                : controller.collect(
                    id: data.originId == null ? data.id! : data.originId!);
          },
          onItemTap: (ArticleEntity data) {},
        );
      },
    );
  }

  List<Widget>? headers() {
    return null;
  }

  List<Widget>? footers() {
    return null;
  }
}
