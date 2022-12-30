import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:wanandroid_flutter_re/base/logic/BaseDefaultController.dart';
import 'package:wanandroid_flutter_re/base/logic/state/DataUIState.dart';
import 'package:wanandroid_flutter_re/base/model/BaseDefaultModel.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanDefaultController.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanDefaultModel.dart';
import 'package:wanandroid_flutter_re/entity/tab_tag_entity.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/model/WechatModel.dart';

class WechatController extends BaseWanDefaultController<List<TabTagEntity>> {
  static const String tag = "WechatController";

  ///单例创建对象 WechatController 需要持久化 所以不需要每次都创建
  static WechatController? _instance;

  static WechatController get instance {
    _instance ??= WechatController._internal();

    return _instance!;
  }

  WechatController._internal();

  final _pageCache = HashMap<int, Widget>();

  Widget? getPageCache(int cid) => _pageCache[cid];


  int curIndex = 0;

  updatePage(int cid, Widget page) {
    _pageCache[cid] = page;
  }

  @override
  List<TabTagEntity>? convertData(DataUIState<dynamic> state, result) {
    final realResult = result as WanCommonResultEntity;
    return realResult.data as List<TabTagEntity>;
  }

  @override
  BaseWanDefaultModel creatModel() => WechatModel();
}
