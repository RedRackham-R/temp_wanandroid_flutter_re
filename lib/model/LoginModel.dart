import 'package:wanandroid_flutter_re/net/WanService.dart';
import '../entity/wan_common_result_entity.dart';

class LoginModel {
  /// 注册
  Future<WanCommonResultEntity> netFetchLogin({
    required String username,
    required String password,
  }) =>
      WanService.fetchLogin(username: username, password: password);

  ///注册并登录
  Future<WanCommonResultEntity> netFetchRegistLogin({
    required String username,
    required String password,
  }) async {
    final registResult =
        await WanService.fetchRegist(username: username, password: password);
    if (!registResult.isSuccess()) {
      return registResult;
    } else {
      final loginResult =
          await WanService.fetchLogin(username: username, password: password);
      return loginResult;
    }
  }
}
