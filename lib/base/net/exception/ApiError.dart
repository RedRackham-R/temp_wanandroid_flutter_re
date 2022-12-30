enum ApiError {
  /// It occurs when url is opened timeout.
  CONNECT_TIMEOUT(1000, "网络连接超时，请稍后重试"),

  /// It occurs when url is sent timeout.
  SEND_TIMEOUT(1001, "发送超时，请稍后重试"),

  ///It occurs when receiving timeout.
  RECEIVE_TIMEOUT(1002, "接收超时，请稍后重试"),

  /// When the server response, but with a incorrect status, such as 404, 503...
  RESPONSE(1003, "与服务通信异常，请稍后重试"),

  /// When the request is cancelled, dio will throw a error with this type.
  CANCEL(1004, "请求已取消"),

  /// Default error type, Some other Error. In this case, you can
  /// use the DioError.error if it is not null.
  OTHER(1005, "请求失败，请稍后再试"),

  UNKNOW(1006, "其他错误");

  final int code;
  final String value;

  const ApiError(this.code, this.value);

  int getCode() {
    return code;
  }

  String getValue() {
    return value;
  }
}
