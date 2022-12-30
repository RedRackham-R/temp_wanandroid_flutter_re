import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid_flutter_re/entity/tab_tag_entity.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';


class SystemItem extends StatefulWidget {
  Function(TabTagEntity) onTap;
  TabTagEntity data;

  SystemItem({
    Key? key,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SystemItemState();
}

class _SystemItemState extends State<SystemItem> {
  @override
  Widget build(BuildContext context) {
    String content = "";
    widget.data.children?.forEach((element) {
      content += "${element.name!}     ";
    });
    return InkWell(
      onTap: () {
        widget.onTap(widget.data);
      },
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(
              vertical: 4.h,
              horizontal: 4.w,
            ),
            title: Text(
              widget.data.name.toString(),
              style: TextStyle(
                fontSize: 14.sp,
              ),
            ),
            subtitle: Text(content),
            trailing: const SizedBox(
              height: double.infinity,
              child: Icon(Icons.arrow_forward_ios),
            ),
          ),
          Container(
            width: double.infinity,
            color: extCurrentTheme().dividerColor,
            height: 1.h,
          ),
        ],
      ),
    );
  }
}
