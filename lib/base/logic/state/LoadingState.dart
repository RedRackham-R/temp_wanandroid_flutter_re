enum LoadStateType { LOADING, SUCCESS, FAILURE, NO_MORE, EMPTY }

class LoadingState {
  LoadStateType type;
  String? msg;

  LoadingState({
    required this.type,
    this.msg,
  });

  static LoadingState creatDefault() {
    return LoadingState(
      type: LoadStateType.LOADING,
      msg: null,
    );
  }

  @override
  String toString() {
    return "LoadStateType = $type   msg = $msg";
  }
}
