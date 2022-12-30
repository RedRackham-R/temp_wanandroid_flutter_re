import 'package:flutter/material.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';


///点击图标变成加载条的空间
class TapLoadingWidget extends StatefulWidget {
  Widget defaultWidget;
  double size;
  bool loading;
  Function onPress;

  TapLoadingWidget({
    required this.onPress,
    this.size = 24,
    this.defaultWidget = const Icon(Icons.add),
    this.loading = false,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TapLoadingWidget();
}

class _TapLoadingWidget extends State<TapLoadingWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.loading) {
      return _creatLoadingWidget();
    } else {
      return GestureDetector(
        onTap: () {
          if (!widget.loading) {
            widget.loading = true;
            widget.onPress();
            setState(() {});
          }
        },
        child: widget.loading ? _creatLoadingWidget() : widget.defaultWidget,
      );
    }
  }

  Widget _creatLoadingWidget() {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: CircularProgressIndicator(
        //加载进度条
        backgroundColor: Colors.grey[200],
        valueColor: AlwaysStoppedAnimation(extCurrentTheme().primaryColor),
      ),
    );
  }
}
