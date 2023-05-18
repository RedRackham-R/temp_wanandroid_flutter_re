import 'package:flutter/material.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatelessWidget {
  static const String TAG = "WebPage";
  final WebViewController _webController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          extLog(msg: "${WebPage.TAG} progress:$progress");
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        // onNavigationRequest: (NavigationRequest request) {},
      ),
    );

  WebPage({Key? key}) : super(key: key) {
    _webController.loadRequest(Uri.parse('https://flutter.dev'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //去掉阴影
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: const Text(
          "实用教程",
        ),
      ),
      body: WebViewWidget(
        controller: _webController,
      ),
    );
  }
}
