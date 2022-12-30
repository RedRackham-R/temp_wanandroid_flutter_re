import 'package:wanandroid_flutter_re/entity/login_entity.dart';

class UserState {
  LoginEntity? info;


  isLogin() => (info != null);

  UserState({this.info});
}
