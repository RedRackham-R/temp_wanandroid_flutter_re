import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';

class CacheManager {
  //用户信息
  static Future<String?> fetch_user_info() => _getString("login_info");

  static Future save_user_info(
    final String? userinfo,
  ) async {
    if (userinfo.isNullOrEmpty()) {
      _remove("login_info");
    } else {
      _putString("login_info", userinfo!);
    }
  }

  //系统设置
  static Future<String?> fetch_settings() => _getString("settings");

  static Future save_settings(final String settings) async {
    _putString("settings", settings);
  }

  //搜索历史记录
  static Future<String?> fetch_history_keywords() async =>
      _getString("history_keywords");

  static Future save_history_keywords(final String keywords) async {
    _putString("history_keywords", keywords);
  }

  static _remove(final String key) async {
    // if (kIsWeb) {
    //   final Storage localStorage = window.localStorage;
    //   return localStorage.remove(key);
    // } else {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   prefs.remove(key);
    // }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static Future<String?> _getString(final String key) async {
    // if (kIsWeb) {
    //   final Storage localStorage = window.localStorage;
    //   return localStorage[key];
    // } else {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   return prefs.getString(key);
    // }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static _putString(final String key, final String value) async {
    // if (kIsWeb) {
    //   final Storage localStorage = window.localStorage;
    //   return localStorage[key] = value;
    // } else {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   prefs.setString(key, value);
    // }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
}
