import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid_flutter_re/entity/coin_list_entity.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/global/ext/ThemeExt.dart';



class CoinItem extends StatelessWidget {
  final CoinListDatas item;
  late String descStr;

  CoinItem({super.key, required this.item}) {
    if (item.desc!.contains("积分")) {
      descStr =
          item.desc!.substring(item.desc!.indexOf("积分"), item.desc!.length);
    } else {
      descStr = "数据格式异常";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(
          left: 10.w,
          right: 10.w,
          top: 10.h,
          bottom: 10.h,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                item.reason!,
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    descStr,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    DateUtil.formatDateMs(item.date!,
                        format: DateFormats.y_mo_d_h_m),
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: extUseColorWithDarkMod(
                        targetColor: extCurrentTheme().textTheme.headline1!.color!,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  "+ ${item.coinCount}",
                  style: TextStyle(
                    fontSize: 16.sp,
                    // fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: extUseColorWithDarkMod(
                      targetColor: extCurrentTheme().primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
