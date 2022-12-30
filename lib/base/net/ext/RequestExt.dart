import 'dart:async';

import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wanandroid_flutter_re/base/logic/BaseController.dart';
import 'package:wanandroid_flutter_re/base/logic/state/LoadingState.dart';
import 'package:wanandroid_flutter_re/base/net/exception/AppException.dart';

typedef Success = Function(dynamic result);
typedef Failure = Function(AppException e);

extension RequestGetxExt2 on GetxController {
  StreamSubscription extRequest<T>({
    required Future<T> future,
    required Success? success,
    required Failure? failure,
    String loadingMsg = "加载中，请稍等...",
  }) {
    StreamSubscription subscription =
        Stream.fromFuture(future).doOnData((event) {
      if (success != null) {
        success(event);
      }
    }).doOnError((p0, p1) {
      if (failure != null) {
        failure(p0 as AppException);
      }
    }).listen((event) {});
    return subscription;
  }
}

extension RequestExt on BaseController {
  extShowEmptyPage({
    required msg,
  }) {
    updateLoadingState = LoadingState(
      type: LoadStateType.EMPTY,
      msg: msg,
    );
  }

  extShowLoadingPage({
    required msg,
  }) {
    updateLoadingState = LoadingState(
      type: LoadStateType.LOADING,
      msg: msg,
    );
  }

  extShowErrorPage({
    required msg,
  }) {
    updateLoadingState = LoadingState(
      type: LoadStateType.FAILURE,
      msg: msg,
    );
  }

  StreamSubscription extRequest<T>({
    required Future<T> future,
    required Success? success,
    required Failure? failure,
    bool withLoading = true,
    String loadingMsg = "加载中，请稍等...",
  }) {
    if (withLoading) {
      extShowLoadingPage(msg: loadingMsg);
    }
    StreamSubscription subscription =
        Stream.fromFuture(future).doOnData((event) {
      if (withLoading) {
        updateLoadingState = LoadingState(
          type: LoadStateType.SUCCESS,
          msg: loadingMsg,
        );
      }
      if (success != null) {
        success(event);
      }
    }).doOnError((p0, p1) {
      if (withLoading) {
        extShowErrorPage(msg: p0.toString());
      }
      if (failure != null) {
        failure(p0 as AppException);
      }
    }).listen((event) {});
    return subscription;
  }
}
