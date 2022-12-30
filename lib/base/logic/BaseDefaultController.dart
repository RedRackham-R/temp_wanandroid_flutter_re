import 'package:wanandroid_flutter_re/base/BaseConstant.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/base/logic/BaseController.dart';
import 'package:wanandroid_flutter_re/base/logic/state/DataUIState.dart';
import 'package:wanandroid_flutter_re/base/model/BaseDefaultModel.dart';
import 'package:wanandroid_flutter_re/base/net/exception/AppException.dart';
import 'package:wanandroid_flutter_re/base/net/ext/RequestExt.dart';

///处理打开页面访问网络逻辑
abstract class BaseDefaultController<T, M extends BaseDefaultModel>
    extends BaseController {
  late final BaseDefaultModel _model = creatModel();

  M get model => _model as M;

  ///数据state
  var _dataState = DataUIState.creatDefaultState<T>();

  set _updateDataState(DataUIState<T> state) {
    _dataState = state;
    update([BaseConstant.BASE_KEY_UPDATE_DATA_STATE]);
  }

  DataUIState<T> get dataState => _dataState;

  ///数据
  T? get data => _dataState.data;

  ///额外数据
  dynamic get extraData1 => _dataState.extraData1;

  @override
  void onInit() {
    super.onInit();
    initData(true);
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  @override
  initData(bool isShowLoading) {
    loadData();
  }

  loadData() => _realNetFetchData();

  //获取数据
  _realNetFetchData() {
    extRequest(
      future: _model.creatFetch(),
      withLoading: true,
      failure: (AppException e) {
        _handleFailure(e);
      },
      success: (result) {
        _handleResult(result);
      },
    );
  }

  _handleResult(
    dynamic result,
  ) {
    final isSuccess = checkResult(result);
    final state = DataUIState.creatDefaultState<T>();
    state.isSuccess = isSuccess;
    state.extraData1 = _dataState.extraData1;
    if (isSuccess) {
      T? data = convertData(state, result);
      state.data = data;
    } else {
      extShowErrorPage(msg: resultErrMsg(result));
      state.errMessage = resultErrMsg(result);
    }
    _updateDataState = state;
  }

  _handleFailure(AppException exception) {
    dataState.isSuccess = false;
    dataState.errMessage = exception.errorMsg;
    _updateDataState = dataState;
    extShowToast(exception.errorMsg);
  }

  ///创建model
  M creatModel();

  ///检查返回结果是否正确
  bool checkResult(dynamic result);

  ///转换数据
  T? convertData(DataUIState state, dynamic result);

  ///获取返回数据的消息
  String resultErrMsg(dynamic result);
}
