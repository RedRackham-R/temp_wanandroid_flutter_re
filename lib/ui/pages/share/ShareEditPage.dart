import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/entity/article_entity.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/global/ext/DialogExt.dart';
import 'package:wanandroid_flutter_re/global/ext/ThemeExt.dart';
import 'package:wanandroid_flutter_re/logic/ShareEditPageController.dart';


class ShareEditPage extends StatefulWidget {
  ArticleEntity? _article;

  late ShareEditPageController _controller;

  ShareEditPage({Key? key}) : super(key: key) {
    _controller = Get.find<ShareEditPageController>();
    _article = Get.arguments;
  }

  @override
  State<StatefulWidget> createState() => _ShareEditPageState();
}

class _ShareEditPageState extends State<ShareEditPage> {
  late TextEditingController _titleController;
  late TextEditingController _linkController;
  bool _titleEditEnable = true;
  bool _linkEditEnable = true;

  @override
  void initState() {
    super.initState();
    if (widget._article != null) {
      _titleController = TextEditingController(text: widget._article!.title!);
      _titleController.addListener(() {
        if (_titleController.text != widget._article!.title!) {
          setState(() {
            _linkEditEnable = false;
          });
        } else {
          setState(() {
            _linkEditEnable = true;
          });
        }
      });
      _linkController = TextEditingController(text: widget._article!.link!);
      _linkController.addListener(() {
        if (_linkController.text != widget._article!.link!) {
          setState(() {
            _titleEditEnable = false;
          });
        } else {
          setState(() {
            _titleEditEnable = true;
          });
        }
      });
    } else {
      _titleController = TextEditingController();
      _linkController = TextEditingController();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _linkController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, //根据输入法高度自动弹起
      backgroundColor: extCurrentTheme().cardColor,
      appBar: AppBar(
        title: Text(
          widget._article == null ? "分享文章" : "编辑文章",
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.help_outline,
            ),
            onPressed: () {
              extShowBottomMessageDialog(
                context: context,
                text: widget._article == null
                    ? "分享说明：\n\n 1. 只要是任何好文都可以分享哈，并不一定要是原创！投递的文章会进入广场 tab。\n 2. CSDN，掘金，简书等官方博客站点会直接通过，不需要审核。\n 3. 其他个人站点会进入审核阶段，不要投递任何无效链接，测试的请尽快删除，否则可能会对你的账号产生一定影响。\n 4. 目前处于测试阶段，如果你发现500等错误，可以向我提交日志，让我们一起使网站变得更好。\n 5. 由于本站只有我一个人开发与维护，会尽力保证24小时内审核，当然有可能哪天太累，会延期，请保持佛系...\n"
                    : "注意！\n\n编辑文章只能单独修改【标题】或【文章链接】，修改其中一项后另一项将会变为不可编辑状态。重新发布后相当于创建新的文章，旧的文章在我的分享中不可见。\n\n新的文章需要重新收藏。如果之前收藏过旧的文章，还是可以在【我的收藏-文章】中查看到旧的文章。\n\n请谨慎操作！\n",
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _creatItemSpace(),
              _creatTitleItem(
                title: "文章标题：",
                btnTitle: "重置标题",
                onTap: () {
                  extFocusHideKeyboard();

                  ///使用TextSelection.fromPosition 修改光标位置
                  final title =
                      (widget._article == null) ? "" : widget._article!.title!;
                  _titleController.value = TextEditingValue(
                    text: title,
                    selection: TextSelection.fromPosition(
                      TextPosition(
                          affinity: TextAffinity.downstream,
                          offset: title.length),
                    ),
                  );
                },
              ),
              _creatItemSpace(),
              TextFormField(
                controller: _titleController,
                enabled: _titleEditEnable,
                // initialValue: (article == null) ? "" : article!.title,
                maxLines: 1,
                maxLength: 80,
                style: TextStyle(
                  fontSize: 12.sp,
                ),
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "文章标题（80字以内）",
                  border: _editBorder(),
                ),
              ),
              _creatItemSpace(),
              _creatTitleItem(
                title: "文章链接：",
                btnTitle: "重置链接",
                onTap: () {
                  extFocusHideKeyboard();

                  ///使用TextSelection.fromPosition 修改光标位置
                  final link =
                      (widget._article == null) ? "" : widget._article!.link!;
                  _linkController.value = TextEditingValue(
                    text: link,
                    selection: TextSelection.fromPosition(
                      TextPosition(
                          affinity: TextAffinity.downstream,
                          offset: link.length),
                    ),
                  );
                },
              ),
              _creatItemSpace(),
              TextFormField(
                controller: _linkController,
                enabled: _linkEditEnable,
                // initialValue: (article == null) ? "" : article!.link,
                style: TextStyle(
                  fontSize: 12.sp,
                ),
                textAlign: TextAlign.start,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  hintText: "如：https://www.wanandroid.com/blog/show/2717",
                  border: _editBorder(),
                ),
              ),
              _creatItemSpace(),
              _creatTitleItem(
                title: "",
                btnTitle: "<-测试链接->",
                onTap: () {
                  extUnfocusHideKeyboard();
                  if (_linkController.text.isNullOrEmpty()) {
                    extShowToast("无法打开空链接");
                  } else {
                    extShowToast("打开链接${_linkController.text}");
                  }
                },
              ),
              _creatItemSpace(),
              GestureDetector(
                onTap: () {
                  _shareArticle();
                },
                child: Container(
                  width: 220.w,
                  height: 42.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: extCurrentTheme().primaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: Text(
                    widget._article == null ? "确认分享" : "重新发布",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color:
                          extCurrentTheme().primaryTextTheme.bodyText1!.color,
                    ),
                  ),
                ),
              ),
              // _creatItemSpace(),
              // _creatItemSpace(),
              // widget._article == null
              //     ? const SizedBox()
              //     : Text(
              //         "注意！ 编辑文章只能单独修改【标题】或【文章链接】，修改其中一项后另一项将会变为不可编辑状态。重新发布后相当于创建新的文章，需要重新收藏，旧的文章在我的分享中不可见。\n\n如果之前收藏过旧的文章，还是可以在【我的收藏-文章】中查看。",
              //         style: TextStyle(
              //           fontSize: 12.sp,
              //           color: extCurrentTheme().textTheme.headline1!.color!,
              //         ),
              //       ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _creatItemSpace() {
    return SizedBox(
      height: 18.h,
    );
  }

  ///创建title类型的item
  Widget _creatTitleItem({
    required String title,
    required String btnTitle,
    required VoidCallback onTap,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
          ),
        ),
        const Expanded(
          child: SizedBox(),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            btnTitle,
            style: TextStyle(
              fontSize: 12.sp,
              color: extUseColorWithDarkMod(
                targetColor: extCurrentTheme().primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _editBorder() {
    return const OutlineInputBorder(
      ///设置边框四个角的弧度
      borderRadius: BorderRadius.all(Radius.circular(10)),

      ///用来配置边框的样式
      borderSide: BorderSide(
        ///设置边框的颜色
        // color: Colors.red,
        ///设置边框的粗细
        width: 2.0,
      ),
    );
  }

  _shareArticle() {
    extUnfocusHideKeyboard();
    if (_titleController.text.isEmpty) {
      extShowToast("文章标题不可为空！");
      return;
    }
    if (_linkController.text.isEmpty) {
      extShowToast("文章链接不可为空!");
      return;
    }
    if (!_linkController.text.isURL) {
      extShowToast("文章链接格式不合法，请检查后重试！");
      return;
    }
    extShowComfrimDialog(
      title: widget._article == null ? "确认" : "注意！",
      content: widget._article == null
          ? "是否分享该文章：\n\n【${_titleController.text}】\n\n${_linkController.text}"
          : "重新发布相当于【创建新的文章】，旧的文章在我的分享中不可见。如果用户在【重新发布前收藏过文章】，重新发布后用户收藏栏内【只会保留旧文章】，新的文章需要用户【重新收藏】，请谨慎操作！",
      // : "是否重新发布文章：\n\n【${_titleController.text}】\n\n${_linkController.text}",
      onConfirm: () {
        extDismissDialog();
        widget._controller.fetchShareArticle(
          title: _titleController.text,
          link: _linkController.text,
        );
      },
      cancel: () {
      },
    );
  }
}
