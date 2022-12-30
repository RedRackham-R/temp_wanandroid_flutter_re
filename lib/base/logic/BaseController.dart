import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/base/BaseConstant.dart';
import 'package:wanandroid_flutter_re/base/logic/state/LoadingState.dart';
import 'package:wanandroid_flutter_re/global/ext/DialogExt.dart';

abstract class BaseController extends GetxController {
  var _loadingState = LoadingState.creatDefault();

  LoadingState get loadingState => _loadingState;

  set updateLoadingState(LoadingState state) {
    _loadingState = state;
    update([BaseConstant.BASE_KEY_UPDATE_LOADING_STATE]);
  }

  late Function() _loadingStateListener;

  @override
  onInit() {
    super.onInit();
    if (useLoadingDialogWithState) {
      //添加loading监听 显示加载dialog
      _loadingStateListener = () {
        if (loadingState.type == LoadStateType.LOADING) {
          extShowLoadingDialog();
        } else {
          extDismissDialog();
        }
      };
      addListenerId(
          BaseConstant.BASE_KEY_UPDATE_LOADING_STATE, _loadingStateListener);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (useLoadingDialogWithState) {
      removeListenerId(
          BaseConstant.BASE_KEY_UPDATE_LOADING_STATE, _loadingStateListener);
    }
  }

  initData(bool isShowLoading) {}

  ///根据loading状态显示或关闭dialog 默认false
  bool useLoadingDialogWithState = false;
}
