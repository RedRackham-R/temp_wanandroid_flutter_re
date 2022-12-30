import 'package:get/get.dart';

class ListDataUIState<T> {

  //是否请求成功
  bool isSuccess;

  //错误消息 isSuccess为false才会有
  String errMessage = "";

  //是否为刷新
  bool isRefresh = false;

  //是否为空
  bool isEmpty = false;

  //是否还有更多
  bool hasMore = false;

  //列表数据
  List<T> listData = <T>[];

  //额外数据
  List<dynamic> extraListData1 = <dynamic>[];

  ListDataUIState(this.isSuccess);

  static ListDataUIState<T> creatDefaultState<T>() {
    return ListDataUIState<T>(false);
  }


  @override
  String toString() {
    return 'ListDataUIStatus{isSuccess: $isSuccess, errMessage: $errMessage, isRefresh: $isRefresh, isEmpty: $isEmpty, hasMore: $hasMore, listData length = : ${listData.length}';
  }
}
