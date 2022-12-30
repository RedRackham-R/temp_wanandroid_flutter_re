import 'package:flutter/material.dart';
import 'package:wanandroid_flutter_re/base_wan/BaseWanArticleListPage.dart';
import 'package:wanandroid_flutter_re/logic/ProjectListController.dart';

class ProjectListPage extends StatelessWidget {
  String tag;

  ProjectListPage({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ProjectList(
        tag: tag,
      ),
    );
  }
}

class _ProjectList extends BaseWanArticleListPage<ProjectListController> {
  _ProjectList({required super.tag});
}
