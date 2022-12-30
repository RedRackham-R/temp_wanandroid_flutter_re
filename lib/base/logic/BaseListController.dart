import 'package:wanandroid_flutter_re/base/BaseConstant.dart';
import 'package:wanandroid_flutter_re/base/logic/BaseController.dart';
import 'package:wanandroid_flutter_re/base/logic/state/LoadingState.dart';
import 'package:wanandroid_flutter_re/base/model/BaseListModel.dart';
import 'package:wanandroid_flutter_re/base/net/exception/AppException.dart';
import 'package:wanandroid_flutter_re/base/net/ext/RequestExt.dart';
import 'package:wanandroid_flutter_re/base/logic/state/ListDataUIState.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';

///抽象列表请求功能控制器
abstract class BaseListController<T, M extends BaseListModel>
    extends BaseController {
  late final BaseListModel _model = creatModel();

  M get model => _model as M;

  ///第一次加载
  var _isFristLoad = true;

  ///起始页码
  final int startingIndex = 0;

  ///页面下标
  var _pageIndex = -1;

  ///数据state
  var _dataState = ListDataUIState.creatDefaultState<T>();

  set updateDataState(ListDataUIState<T> state) {
    _dataState = state;
    update([BaseConstant.BASE_KEY_UPDATE_DATA_STATE]);
  }

  ListDataUIState<T> get dataState => _dataState;

  List<T> get data => _dataState.listData;

  List<dynamic> get extraData1 => _dataState.extraListData1;

  ///listview滚动位置保存
  double _listOffset = 0.0;

  double get listOffset => _listOffset;

  set updateListOffset(double offset) {
    _listOffset = offset;
  }

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
    if (_isFristLoad) {
      refreshData();
    }
  }

  loadData() => _realNetFetchData(false);

  refreshData() => _realNetFetchData(true);

  //获取数据
  _realNetFetchData(final bool isRefresh) {
    if (isRefresh) {
      _pageIndex = startingIndex;
    }
    extRequest(
      future: _model.creatFetch(_pageIndex),
      withLoading: _isFristLoad || data.isEmpty,
      failure: (AppException e) {
        _handleFailure(e);
      },
      success: (result) {
        _handleResult(result, isRefresh);
      },
    );
  }

  _handleResult(
    dynamic result,
    bool isRefresh,
  ) {
    final isSuccess = checkResult(result);
    final state = ListDataUIState.creatDefaultState<T>();
    state.isSuccess = isSuccess;
    state.isRefresh = isRefresh;

    if (!isRefresh) {
      state.listData.addAll(data);
      //在这里把缓存的数据保存
      state.extraListData1 = extraData1;
    }

    if (isSuccess) {
      //设置第一次加载状态
      if (_isFristLoad) {
        _isFristLoad = false;
      }
      List<T>? listData = convertData(state, result);
      //第一次加载是否为空
      final bool isFristEmpty = (_pageIndex == startingIndex) &&
          isRefresh &&
          listData.isNullOrEmpty();

      //当前数据算上已经加载的是否是空
      final isEmpty = (listData.isNullOrEmpty() && state.listData.isNotEmpty);

      //是否还有更多数据
      final bool hasMore = hasMoreData(result);

      //第一次加载就是空的直接跳转到空白页
      if (isFristEmpty && !hasMore) {
        extShowEmptyPage(msg: "没有更多数据了");
        return;
      }
      //数据不为空添加数据
      if (!isEmpty) {
        state.listData.addAll(listData);
      }

      //如果还有更多数更新下标
      if (hasMore) {
        _pageIndex++;
      }

      //更新state
      state.isEmpty = isEmpty;
      state.hasMore = hasMore;
    } else {
      if (_isFristLoad) {
        extShowErrorPage(msg: resultErrMsg(result));
        return;
      }
      state.errMessage = resultErrMsg(result);
    }
    updateDataState = state;
  }

  _handleFailure(AppException exception) {
    if (!_isFristLoad) {
      dataState.isSuccess = false;
      dataState.errMessage = exception.errorMsg;
      updateDataState = dataState;
    } else {}
    extShowToast(exception.errorMsg);
  }

  reset() {
    _isFristLoad = true;
    loadingState.type = LoadStateType.LOADING;
    _dataState = ListDataUIState.creatDefaultState<T>();
    _listOffset = 0;
    _pageIndex = startingIndex;
  }

  ///创建model
  M creatModel();

  ///检查返回结果是否正确
  bool checkResult(dynamic result);

  ///转换数据
  List<T> convertData(ListDataUIState state, dynamic result);

  ///判断数据是否还有更多
  bool hasMoreData(dynamic result);

  ///获取返回数据的消息
  String resultErrMsg(dynamic result);
}
