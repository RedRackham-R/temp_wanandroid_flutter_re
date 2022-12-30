import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/global/Constant.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/global/ext/ThemeExt.dart';
import 'package:wanandroid_flutter_re/main.dart';

class TabBarContainer extends StatefulWidget {
  int lenth;
  List<Widget> tabs;
  List<Widget> tabBarViewChildren;
  int initIndex;
  Function(int index) onPageChange;
  bool scrollable;

  TabBarContainer({
    Key? key,
    required this.lenth,
    required this.tabs,
    required this.tabBarViewChildren,
    required this.onPageChange,
    required this.initIndex,
    this.scrollable = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TabContainerState();
}

class _TabContainerState extends State<TabBarContainer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        initialIndex: widget.initIndex, length: widget.lenth, vsync: this);
    _tabController.addListener(() {
      widget.onPageChange(_tabController.index);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.lenth,
      child: Column(
        children: [
          GetBuilder(
            init: globalAppController,
            id: Constant.GLOBAL_APP_SETTINGS_THEME_COLOR,
            builder: (GetxController controller) {
              return Container(
                decoration: BoxDecoration(
                  color: extCurrentTheme().primaryColor,
                ),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: widget.scrollable,
                  tabs: widget.tabs,
                ),
              );
            },
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: widget.tabBarViewChildren,
            ),
          ),
        ],
      ),
    );
  }
}
