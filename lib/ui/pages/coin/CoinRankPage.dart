import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/base/BaseConstant.dart';
import 'package:wanandroid_flutter_re/base/page/BaseListPage.dart';
import 'package:wanandroid_flutter_re/entity/user_coin_entity.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/global/ext/DialogExt.dart';
import 'package:wanandroid_flutter_re/logic/CoinRankController.dart';
import 'package:wanandroid_flutter_re/main.dart';


class CoinRankPage extends StatelessWidget {
  const CoinRankPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(globalAppController.userCoinInfoState.data != null
            ? "积分排行（我的排名：${globalAppController.userCoinInfoState.data!.rank}）"
            : "积分排行"),
      ),
      body: _CoinRankList(
        tag: CoinRankController.tag,
      ),
    );
  }
}

class _CoinRankList extends BaseListPage<CoinRankController> {
  _CoinRankList({required super.tag});

  @override
  Widget creatList() {
    return CustomScrollView(
      slivers: <Widget>[
        // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
        SliverToBoxAdapter(
          child: Column(
            children: [
              _buildTop3Item(0, controller.data[0]),
              _buildTop3Item(1, controller.data[1]),
              _buildTop3Item(2, controller.data[2]),
            ],
          ),
        ),
        // 当列表项高度固定时，使用 SliverFixedExtendList 比 SliverList 具有更高的性能
        SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(_buildListItem,
                childCount: controller.data.length - 3),
            itemExtent: 48.0),
      ],
    );
  }

  // 列表项
  Widget _buildListItem(BuildContext context, int index) {
    final UserCoinEntity item = controller.data[index + 3];
    bool isCurIndex;
    //判断当前位置是否是用户的排名
    if (globalAppController.userCoinInfoState.data != null &&
        globalAppController.userCoinInfoState.data!.rank == item.rank) {
      isCurIndex = true;
    } else {
      isCurIndex = false;
    }
    Color textColor;
    if (isCurIndex) {
      textColor = extCurrentTheme().primaryTextTheme.bodyText1!.color!;
    } else {
      textColor = extCurrentTheme().textTheme.bodyText1!.color!;
    }
    return Card(
      color: isCurIndex
          ? extCurrentTheme().primaryColor
          : extCurrentTheme().cardColor,
      child: Row(
        children: [
          SizedBox(
            width: 14.w,
          ),
          Text(
            item.rank.toString(),
            style: TextStyle(
              fontSize: 18.sp,
              color: textColor,
            ),
          ),
          SizedBox(
            width: 14.w,
          ),
          Text(
            item.username!,
            style: TextStyle(
              color: textColor,
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Text(
            item.coinCount.toString(),
            style: TextStyle(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTop3Item(int index, UserCoinEntity item) {
    Color coinTxColor;
    switch (index) {
      case 0:
        coinTxColor = Colors.amber;
        break;
      case 1:
        coinTxColor = Colors.blueGrey;
        break;
      case 2:
        coinTxColor = Colors.orange;
        break;
      default:
        coinTxColor = extCurrentTheme().textTheme.titleMedium!.color!;
    }

    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            height: 38.w,
            width: 38.w,
            "assets/images/icons/rank$index.png",
          ),
          Text(
            item.username!,
            style: TextStyle(
              fontSize: (20 - index * 2).sp,
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Text(
            item.coinCount.toString(),
            style: TextStyle(
              color: coinTxColor,
              fontSize: (20 - index * 2).sp,
            ),
          ),
        ],
      ),
    );
  }
}
