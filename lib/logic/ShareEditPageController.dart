import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/base/logic/BaseController.dart';
import 'package:wanandroid_flutter_re/base/net/exception/AppException.dart';
import 'package:wanandroid_flutter_re/base/net/ext/RequestExt.dart';
import 'package:wanandroid_flutter_re/entity/wan_common_result_entity.dart';
import 'package:wanandroid_flutter_re/model/ShareEditModel.dart';

class ShareEditPageController extends BaseController {
  final EditShareArticleModel _model = EditShareArticleModel();

  fetchShareArticle({
    required String title,
    required String link,
  }) {
    extRequest(
      future: _model.fetchShareArticle(title: title, link: link),
      success: (result) {
        _handleResult(result);
      },
      failure: (AppException e) {
        _handleFailure(e);
      },
    );
  }

  _handleResult(final dynamic result) {
    extUnfocusHideKeyboard();
    final WanCommonResultEntity realResult = result as WanCommonResultEntity;
    if (realResult.isSuccess()) {
      Get.back(result: true);
    } else {
      extShowToast(realResult.errorMsg);
    }
  }

  _handleFailure(AppException e) {
    extUnfocusHideKeyboard();
    extShowToast(e.errorMsg);
  }

  @override
  bool get useLoadingDialogWithState => true;
}
