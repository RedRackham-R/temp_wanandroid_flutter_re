import 'package:flutter/material.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListPage.dart';
import 'package:wanandroid_flutter_re/logic/SquareController.dart';

class SquarePage extends StatelessWidget {
  const SquarePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _SquareList(),
    );
  }
}

class _SquareList extends BaseWanArticleListPage<SquareController> {
  _SquareList() :super(tag: SquareController.tag);
}
