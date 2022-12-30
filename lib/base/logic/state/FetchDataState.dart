class FetchDataState<T> {
  //是否请求成功
  bool isSuccess;

  //错误消息 isSuccess为false才会有
  String errMessage = "";

  bool isLoading = true;

  //数据
  T? data;

  FetchDataState(this.isSuccess);

  static FetchDataState<T> creatDefaultState<T>() {
    return FetchDataState<T>(false);
  }
}
