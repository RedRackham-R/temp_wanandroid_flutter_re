import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/global/Constant.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/logic/LoginController.dart';
import 'package:wanandroid_flutter_re/main.dart';

import 'package:wanandroid_flutter_re/ui/weight/WaveWeight.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: WaveWeight(
        child: GetBuilder<LoginController>(
          init: controller,
          id: Constant.LOGIN_KEY_CHANGE_PAGE,
          builder: (LoginController controller) {
            return _LoginView(loginController: controller);
          },
        ),
      ),
      onWillPop: () async {
        Get.back();
        return true;
      },
    );
  }
}

class _LoginView extends StatefulWidget {
  LoginController loginController;

  _LoginView({required this.loginController});

  @override
  State<StatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _repasswordController;

  bool _passwrodsVisible = false;

  //Form 状态，用来控制验证
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _repasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _repasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                reverse: true,
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8.h,
                      ),
                      IconButton(
                        color: extCurrentTheme().primaryIconTheme.color,
                        icon: Icon(
                          Icons.close,
                          size: 24.h,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Text(
                          widget.loginController.isLoginPage ? "登录" : "注册",
                          style: TextStyle(
                            fontSize: 24.sp,
                            color: extCurrentTheme().primaryTextTheme.titleMedium!.color,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 38.h,
                      ),

                      _textFieldItem(
                        validator: (value) {
                          return value.isNullOrEmpty() ? "请输入账号！" : null;
                        },
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.close,
                          ),
                          color: Colors.white70,
                          onPressed: () {
                            _usernameController.clear();
                          },
                        ),
                        hint: widget.loginController.isLoginPage
                            ? "Wanandroid账号"
                            : "账号",
                        controller: _usernameController,
                        obscureText: false,
                        inputType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      _textFieldItem(
                        validator: (value) {
                          return value.isNullOrEmpty()
                              ? "请输入密码！"
                              : (value!.length < 8 || value.length > 16)
                                  ? "密码长度应为8-16！！"
                                  : null;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwrodsVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          color: Colors.white70,
                          onPressed: () {
                            setState(() {
                              _passwrodsVisible = !_passwrodsVisible;
                            });
                          },
                        ),
                        hint: widget.loginController.isLoginPage?"密码":"密码（8-16）",
                        controller: _passwordController,
                        obscureText: !_passwrodsVisible,
                        inputType: TextInputType.visiblePassword,
                      ),

                      ///这里判断如果是注册才显示确认密码输入框
                      SizedBox(
                        height: widget.loginController.isLoginPage ? 0 : 18.h,
                      ),

                      widget.loginController.isLoginPage
                          ? const SizedBox()
                          : _textFieldItem(
                              validator: (value) {
                                return value.isNullOrEmpty()
                                    ? '需要再次输入密码'
                                    : (value! != _passwordController.text)
                                        ? "两次输入密码不一致，请确认是否正确！"
                                        : null;
                              },
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwrodsVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                color: Colors.white70,
                                onPressed: () {
                                  setState(() {
                                    _passwrodsVisible = !_passwrodsVisible;
                                  });
                                },
                              ),
                              hint: "再次输入密码",
                              controller: _repasswordController,
                              obscureText: !_passwrodsVisible,
                              inputType: TextInputType.visiblePassword,
                            ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 280.w,
                          child: TextButton(
                            onPressed: () {
                              _check();
                            },
                            style: ButtonStyle(
                              //设置边框
                              side: MaterialStateProperty.all(
                                const BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              //外边框装饰 会覆盖 side 配置的样式 设置为圆形
                              shape: MaterialStateProperty.all(
                                const StadiumBorder(),
                              ),
                            ),
                            child: Text(
                              "完成",
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                _changePage();
              },
              child: Text(
                widget.loginController.isLoginPage
                    ? "没有账号？立即注册。"
                    : "已有账号？马上登录。",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14.sp,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            SizedBox(
              height: 58.h,
            ),
          ],
        ),
      ],
    );
  }

  Widget _textFieldItem({
    required TextEditingController controller,
    required bool obscureText,
    required String hint,
    required Widget suffixIcon,
    required FormFieldValidator<String> validator,
    required TextInputType inputType,
  }) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: SizedBox(
        width: 280.w,
        child: TextFormField(
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          ),
          //是否隐藏密码
          obscureText: obscureText,
          textAlign: TextAlign.start,
          keyboardType: inputType,
          decoration: InputDecoration(
            errorText: "",
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: Colors.white70,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                50.h,
              ),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            contentPadding: EdgeInsets.only(
              top: 8.h,
              bottom: 8.h,
              left: 12.w,
              right: 12.w,
            ),
            fillColor: Colors.white24,
            suffixIcon: suffixIcon,
            isCollapsed: true,
          ),
          cursorColor: Colors.white70,
          validator: validator,
        ),
      ),
    );
  }

  _changePage() {
    _passwrodsVisible = false;
    final saveUsername = _usernameController.text;
    if (saveUsername.isNullOrEmpty()) {
      _usernameController.clear();
    } else {
      _usernameController.text = saveUsername;
    }
    _passwordController.clear();
    _repasswordController.clear();
    (_formKey.currentState as FormState).reset();
    extUnfocusHideKeyboard();
    widget.loginController.changePage();
  }

  _check() {
    extUnfocusHideKeyboard();
    //验证通过提交数据
    if ((_formKey.currentState as FormState).validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;
      if (widget.loginController.isLoginPage) {
        widget.loginController.login(username: username, password: password);
      } else {
        widget.loginController.regist(username: username, password: password);
      }
    }
  }
}
