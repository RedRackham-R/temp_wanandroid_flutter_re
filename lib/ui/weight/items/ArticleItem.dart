import 'package:common_utils/common_utils.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid_flutter_re/entity/article_entity.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';


class ArticleItem extends StatefulWidget {
  final ArticleEntity article;
  final Function(ArticleEntity data) onItemTap;
  final Function(ArticleEntity data) onCollectTap;

  const ArticleItem(
      {required this.article,
      required this.onItemTap,
      required this.onCollectTap,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ArticleItemState();
  }
}

class _ArticleItemState extends State<ArticleItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //上部分控件
    final headWidgets = <Widget>[];
    //中部分控件
    final contentWidgets = <Widget>[];
    //下部分控件
    final bottomWidgets = <Widget>[];

    //公共部分数据和组件
    final data = widget.article;
    bool isCollect = data.collect ?? false;
    var userName = data.author.isNullOrEmpty()
        ? data.shareUser.isNullOrEmpty()
            ? "--"
            : data.shareUser!
        : data.author!;
    final tagList = data.tags;
    final time =
        DateUtil.formatDateMs(data.publishTime!, format: DateFormats.full);
    final title = data.title!;

    String classify;
    if (data.superChapterName.isNullOrEmpty()) {
      classify = "${data.chapterName}";
    } else {
      classify = "${data.superChapterName}-${data.chapterName}";
    }

    final tagColors = <Color>[
      Colors.orange,
      Colors.indigo,
      Colors.blueGrey,
      Colors.deepPurple,
    ];
    final picUrl = data.envelopePic;
    final hasPic = picUrl.isNotEmpty();
    final desc = data.desc;

    //添加用户名
    headWidgets.add(Text(
      userName,
      style: TextStyle(
        fontSize: 11.sp,
      ),
    ));
    //填充控件
    headWidgets.add(SizedBox(
      width: 4.w,
    ));
    //添加置顶标签
    if (data.isTop()) {
      headWidgets.add(_itemTag("置顶", Colors.red));
    }

    //填充控件
    headWidgets.add(SizedBox(
      width: 4.w,
    ));

    //添加[新]标签

    if (data.fresh != null && data.fresh!) {
      headWidgets.add(_itemTag("新", Colors.blue));
      //填充控件
      headWidgets.add(SizedBox(
        width: 4.w,
      ));
    }
    //添加tag标签
    int tagColorIndex = 0;
    if (!tagList.isNullOrEmpty()) {
      for (var index = 0; index < tagList!.length; index++) {
        Color tagColor = tagColors[tagColorIndex];
        headWidgets.add(_itemTag(tagList[index].name, tagColor));
        //填充控件
        if (index != tagList.length - 1) {
          headWidgets.add(SizedBox(width: 4.w));
        } else {
          //Expanded把主轴撑开
          headWidgets.add(const Expanded(
            child: SizedBox(),
          ));
        }
        tagColorIndex++;
        if (tagColorIndex > tagColors.length - 1) {
          tagColorIndex = 0;
        }
      }
    }

    //填充row的控件
    headWidgets.add(const Expanded(child: SizedBox()));

    // //添加时间
    headWidgets.add(Text(
      time,
      style: TextStyle(fontSize: 10.sp),
    ));

    //添加中间部分
    if (hasPic) {
      contentWidgets.add(_projectContentWidget(title, picUrl!, desc!));
    } else {
      contentWidgets.add(_articleContentWidget(title));
    }

    bottomWidgets.add(
      Expanded(
        child: Text(
          classify,
          maxLines: 1,
          softWrap: true,
          style: TextStyle(
              fontSize: 10.sp,
              color: Colors.green,
              overflow: TextOverflow.ellipsis),
        ),
      ),
    );

    bottomWidgets.add(GestureDetector(
      onTap: () {
        if (!data.extIsCollecting) {
          data.extIsCollecting = true;
          widget.onCollectTap(widget.article);
          setState(() {});
        }
      },
      child: data.extIsCollecting
          ? SizedBox(
              height: extCurrentTheme().iconTheme.size,
              width: extCurrentTheme().iconTheme.size,
              child: CircularProgressIndicator(
                //加载进度条
                backgroundColor: Colors.grey[200],
                valueColor:
                    AlwaysStoppedAnimation(extCurrentTheme().primaryColor),
              ),
            )
          : Icon(
              isCollect ? Icons.favorite : Icons.favorite_border,
              color: isCollect ? Colors.red : Colors.grey,
            ),
    ));

    return InkWell(
      //使用InkWell 点击会有水纹效果， 如果是GestureDetector则无效果
      onTap: () {
        widget.onItemTap(widget.article);
      },
      child: Container(
        color: extCurrentTheme().cardColor,
        //EdgeInsets 配置间隔
        padding: EdgeInsets.only(
          left: 4.w,
          top: 8.h,
          right: 8.w,
          bottom: 4.h,
        ),
        child: Column(
          children: [
            Row(
              children: headWidgets,
            ),
            Row(
              children: [
                SizedBox(
                  height: 16.h,
                )
              ],
            ),
            Row(
              children: contentWidgets,
            ),
            Row(
              children: [
                SizedBox(
                  height: 16.h,
                )
              ],
            ),
            Row(
              children: bottomWidgets,
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemTag(String tag, Color color) {
    return Container(
        //设置 child 居中
        alignment: Alignment.center,
        //边框设置
        decoration: BoxDecoration(
          //背景
          color: Colors.transparent,
          //设置四周圆角 角度
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          //设置四周边框
          border: Border.all(width: 1, color: color),
        ),
        child: Container(
          margin: EdgeInsets.only(left: 4.w, top: 1.h, right: 4.w, bottom: 1.h),
          child: Text(tag, style: TextStyle(fontSize: 10.sp, color: color)),
        ));
  }

  ///无图片文章控件
  Widget _articleContentWidget(String title) => Expanded(
        // 设置Expanded省略才会有效 因为直接设置Text回撑开Row,没有设置Row宽度就 类似无限宽度
        child: Text(
          title,
          maxLines: 2,
          softWrap: true,
          style: TextStyle(fontSize: 14.sp, overflow: TextOverflow.ellipsis),
        ),
      );

  ///有图片文章控件
  Widget _projectContentWidget(String title, String picUrl, String desc) =>
      Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
              child: Image.network(
                picUrl,
                width: 100.w,
                height: 100.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 4.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 14.sp, overflow: TextOverflow.ellipsis),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    desc,
                    maxLines: 5,
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
