import 'package:flutter/material.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListPage.dart';
import 'package:wanandroid_flutter_re/logic/WechatListController.dart';

class WechatListPage extends StatelessWidget {
  String tag;

  WechatListPage({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _WechatList(
        tag: tag,
      ),
    );
  }
}

class _WechatList extends BaseWanArticleListPage<WechatListController> {
  _WechatList({required super.tag});
}
