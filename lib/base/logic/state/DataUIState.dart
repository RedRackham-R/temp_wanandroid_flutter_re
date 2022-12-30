class DataUIState<T> {
  //是否请求成功
  bool isSuccess;

  //错误消息 isSuccess为false才会有
  String errMessage = "";

  //数据
  T? data;

  //额外数据
  dynamic extraData1;

  DataUIState(this.isSuccess);

  static DataUIState<T> creatDefaultState<T>() {
    return DataUIState<T>(false);
  }

  @override
  String toString() {
    return 'ListDataUIStatus{isSuccess: $isSuccess, errMessage: $errMessage, data:$data}';
  }
}
