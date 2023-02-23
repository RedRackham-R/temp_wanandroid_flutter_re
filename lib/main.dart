import 'dart:io';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/global/GlobalAppController.dart';
import 'package:wanandroid_flutter_re/global/GlobalCollectController.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/net/RequestHandler.dart';
import 'package:wanandroid_flutter_re/net/WanAPI.dart';
import 'package:wanandroid_flutter_re/net/WanService.dart';
import 'package:wanandroid_flutter_re/net/interceptor/WebCookieInterceptor.dart';
import 'package:wanandroid_flutter_re/routes/routes_config.dart';

import 'package:wanandroid_flutter_re/utils/PermissionUtils.dart';

late GlobalAppController globalAppController;
late GlobalCollectController globalCollectController;

void main() async {
  //通过ensureInitialized 创建WidgetsFlutterBinding单例对象
  //有时候我们会在发现有的app 在在运行应用程序之前先与 Flutter Engine 进行通信，
  // 所以要先将WidgetsFlutterBinding.ensureInitialized()提前。
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Wanandroid',
          // You can use the library anywhere in the app even in theme
          theme: extCurrentTheme(),
          initialRoute: RoutesConfig.SPLASH,
          getPages: RoutesConfig.getPages,
        );
      },
    );
  }
}

//做一些需要初始化的配置，比如说蛋疼的cookie_manager
_initializeApp() async {
  if (defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android) {
    await _initMobilePlatform();
  } else if (defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.windows) {
    await _initDesktopPlatform();
  } else {
    await _initOtherPlatform();
  }
  //添加全局配置controller
  Get.put(
    GlobalAppController(),
    permanent: true, //持久化
  );
  Get.put(
    GlobalCollectController(),
    permanent: true, //持久化
  );
  globalAppController = Get.find<GlobalAppController>();
  globalCollectController = Get.find<GlobalCollectController>();
  //初始化controller的数据
  await globalAppController.init();
}

_initOtherPlatform() async {
  print("Other platform initializing...");
  Directory td = await getTemporaryDirectory();
  print("Directory = ${td.toString()}");
  await _initAPIForApp(dir: "");
}

_initDesktopPlatform() async {
  print("Desktop platform initializing...");
  extLog(msg: "isWeb $kIsWeb");

  ///这里区分是web还是桌面操作系统应用（windows）
  if (kIsWeb) {
    await _initAPIForWeb();
  } else {
    await _initAPIForWeb();
    // Directory td = await getTemporaryDirectory();
    // await _initAPIForApp(dir: td.path);
  }
}

///移动平台初始化
_initMobilePlatform() async {
  print("Mobile platform initializing...");
  Directory appDocDir = await getApplicationDocumentsDirectory();
  await PermissionUtil.checkPermission(
    permissionList: <Permission>[
      Permission.storage,
    ],
    onSuccess: () {
      _initAPIForApp(dir: appDocDir.path);
    },
    onFailed: () {
      _initAPIForApp();
      extShowToast("注意！ 未授予权限无法保存登录状态");
    },
  );
}

_initAPIForWeb() async {
  final WebCookieInterceptor interceptor = WebCookieInterceptor();
  requestHandler = RequestHandler(
    baseUrl: WanAPI.BASE_URL,
    cookieInterceptor: interceptor,
  );
}

_initAPIForApp({String dir = ""}) async {
  final CookieManager cookieManager;
  String cookiePath = "$dir/.wan_cookies/";
  print("cookie path:$cookiePath");
  final cookieJar = PersistCookieJar(storage: FileStorage(cookiePath));
  cookieManager = CookieManager(cookieJar);
  //cookie保存在内存 这里不需要，登录必须保存到本地
  //cookieManager = CookieManager(CookieJar());

  requestHandler = RequestHandler(
    baseUrl: WanAPI.BASE_URL,
    cookieInterceptor: cookieManager,
  );
}
