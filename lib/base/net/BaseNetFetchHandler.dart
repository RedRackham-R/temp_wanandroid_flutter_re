import 'package:dio/dio.dart';
import 'package:wanandroid_flutter_re/base/net/exception/ExceptionHandler.dart';

///网络请求处理类 实现基本get post 请求以及常规异常处理
abstract class BaseNetFetchHandler {
  final Dio _dio = Dio();

  BaseNetFetchHandler() {
    //配置option 没有就默认
    var options = setOptions();
    if (options != null) {
      _dio.options = options;
    }
    //配置拦截器 没有就默认
    var interceptors = setInterceptors();
    if (interceptors != null) {
      for (var interceptor in interceptors) {
        addInterceptor(interceptor);
      }
    }
    //配置适配器 没有就默认
    var adapter = setHttpClientAdapter();
    if (adapter != null) {
      _dio.httpClientAdapter = adapter;
    }
    //配置转换器
    setTransformer(_dio.transformer as DefaultTransformer);
  }

  List<Interceptor>? setInterceptors();

  BaseOptions? setOptions();

  HttpClientAdapter? setHttpClientAdapter();

  addInterceptor(Interceptor interceptor) => _dio.interceptors.add(interceptor);

  void setTransformer(DefaultTransformer transformer) {}

  /// check Options.
  Options _checkOptions(options) {
    options ??= Options();
    return options;
  }

  ///网络get获取
  Future<Response> postFetch({
    required String path,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    Response response;
    try {
      response = await _dio.post(
        path,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
    } on DioError catch (de) {
      throw ExceptionHandler.handleDioException(de);
    } on Exception catch (e) {
      throw ExceptionHandler.handleException(e);
    }
    return response;
  }

  ///网络get获取
  Future<Response> getFetch({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    Response response;
    try {
      response = await _dio.get(
        path,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
      );
    } on DioError catch (de) {
      throw ExceptionHandler.handleDioException(de);
    } catch (e) {
      throw ExceptionHandler.handleException(e as Exception);
    }
    return response;
  }

  ///网络获取 自行配置
  Future<Response?> request(
      String path, data, Options? options, CancelToken cancelToken) async {
    Response response;
    try {
      response = await _dio.request(
        path,
        data: data,
        options: _checkOptions(options),
        cancelToken: cancelToken,
      );
    } on DioError catch (de) {
      throw ExceptionHandler.handleDioException(de);
    } catch (e) {
      throw ExceptionHandler.handleException(e as Exception);
    }
    return response;
  }
}
