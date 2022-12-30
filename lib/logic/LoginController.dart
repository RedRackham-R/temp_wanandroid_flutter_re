import 'dart:async';

import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/base/BaseConstant.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/base/logic/BaseController.dart';
import 'package:wanandroid_flutter_re/base/logic/state/LoadingState.dart';
import 'package:wanandroid_flutter_re/base/net/exception/AppException.dart';
import 'package:wanandroid_flutter_re/base/net/ext/RequestExt.dart';
import 'package:wanandroid_flutter_re/entity/login_entity.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/global/Constant.dart';
import 'package:wanandroid_flutter_re/global/ext/DialogExt.dart';
import 'package:wanandroid_flutter_re/main.dart';
import 'package:wanandroid_flutter_re/model/LoginModel.dart';

class LoginController extends BaseController {
  final _model = LoginModel();

  ///当前页面 登录 or 注册
  var _isLoginPage = true;

  bool get isLoginPage => _isLoginPage;

  changePage() {
    _isLoginPage = !_isLoginPage;
    update([Constant.LOGIN_KEY_CHANGE_PAGE]);
  }

  login({
    required String username,
    required String password,
  }) {
    extRequest(
      future: _model.netFetchLogin(username: username, password: password),
      success: (result) {
        _handleResult(result);
      },
      failure: (AppException e) {
        _handleFailure(e);
      },
    );
  }

  regist({
    required String username,
    required String password,
  }) {
    extRequest(
      future:
          _model.netFetchRegistLogin(username: username, password: password),
      success: (result) {
        _handleResult(result);
      },
      failure: (AppException e) {
        _handleFailure(e);
      },
    );
  }

  _handleResult(WanCommonResultEntity result) {
    //成功就直接
    if (result.isSuccess()) {
      globalAppController.loginIn(entity: result.data as LoginEntity);
      globalAppController.netFetchUserCoinInfo();
      extShowToast("欢迎回来，${globalAppController.userState.info!.nickname}");
      Get.back();
    } else {
      extShowToast(result.errorMsg);
    }
  }

  _handleFailure(AppException e) {
    extShowToast(e.errorMsg);
  }

  @override
  bool get useLoadingDialogWithState => true;
}
